import 'package:first_app/Models/BulkExtractorResponse.dart';
import 'package:first_app/Models/GrepResponse.dart';
import 'package:first_app/Models/SqueezeRequest.dart';
import 'package:first_app/Models/VolatilityResponse.dart';
import 'package:first_app/Services/BulkExtractorServices.dart';
import 'package:first_app/Services/MemdumpGrepServices.dart';
import 'package:first_app/Services/PagefileGrepServices.dart';
import 'package:flutter/material.dart';
import 'package:first_app/Utils/utils.dart';
import 'package:first_app/Services/VolatilityServices.dart';


class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {

  bool pslist = false;
  bool pstree = false;
  bool netscan = false;
  bool filescan = false;
  bool timeliner = false;
  bool bulkextractor = false;
  bool memdumpGrep = false;
  bool pagefileGrep = false;

  String loadingMessage = "";
  String executingMessage = "";
  
  Map<String,VolatilityResponse> allVolatilityResponses = {};


  Future setMessageState(String loadMsg, String execMsg) async {
    setState(() {
      loadingMessage = loadMsg;
      executingMessage = execMsg;
    });
    return Future.delayed(Duration(seconds: 4), () => "3");
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    //Recupero le keyword inserite
    SqueezeRequest request = ModalRoute.of(context).settings.arguments;

    //Controllo che le keyword siano state recuperate correttamente
    if (request != null){
      await setMessageState("Sto analizzando il dump, metitti comodo, ci vorrà un po!", "Sto eseguendo pslist...");
      
      VolatilityResponse resPslist = await VolatilityServices.psList(request.os); //Eseguo pslist
      
      //Controllo se pslist è andato a buon fine
      if (!resPslist.isBlank){
        await setMessageState("Sto analizzando il dump, metitti comodo, ci vorrà un po!", "Esecuzione di pslist riuscita");

        
        allVolatilityResponses["pslist"] = resPslist;
        pslist = true;

        if(request.os == "windows"){
          await setMessageState("Sto analizzando il dump, metitti comodo, ci vorrà un po!", "Sto eseguendo netscan...");
  
        } else {
          await setMessageState("Netscan non supporta questo sistema operativo...", "Passo al prossimo tool!");
  
        }

        VolatilityResponse resNetscan = await VolatilityServices.netScan(request.os); //Eseguo netscan

        //Controllo che netscan sia andato a buon fine
        if (!resNetscan.isBlank){
          if(request.os == "windows"){
            await setMessageState("Sto analizzando il dump, metitti comodo, ci vorrà un po!", "Esecuzione di netscan riuscita");
    
            allVolatilityResponses["netscan"] = resNetscan;
          }
          netscan = true;

          if(request.os == "windows"){
            await setMessageState("Sto analizzando il dump, metitti comodo, ci vorrà un po!", "Sto eseguendo filescan...");
    
          } else {
          await setMessageState("Filescan non supporta questo sistema operativo...", "Passo al prossimo tool!");
  
          }

          VolatilityResponse resFilescan = await VolatilityServices.fileScan(request.os); //Eseguo filescan

          //Controllo che netscan sia andato a buon fine
          if (!resFilescan.isBlank){
            if(request.os == "windows"){
              await setMessageState("Sto analizzando il dump, metitti comodo, ci vorrà un po!", "Esecuzione di filescan riuscita");
      
              allVolatilityResponses["filescan"] = resFilescan;
            }

            filescan = true;

            await setMessageState("Sto analizzando il dump, metitti comodo, ci vorrà un po!", "Sto eseguendo timeliner...");

            VolatilityResponse resTimeliner = await VolatilityServices.timeliner(request.os); //Eseguo timeliner

            if (!resTimeliner.isBlank){
              await setMessageState("Sto analizzando il dump, metitti comodo, ci vorrà un po!", "Esecuzione di timeliner riuscita");
      
              allVolatilityResponses["timeliner"] = resTimeliner;

              timeliner = true;

              await setMessageState("Sto analizzando il dump, metitti comodo, ci vorrà un po!", "Sto eseguendo bulk_extractor...");
              
              BulkExtractorResponse beRes = await BulkExtractorServices.be(request);

              if(!beRes.isBlank) {
                await setMessageState("Sto analizzando il dump, metitti comodo, ci vorrà un po!", "Esecuzione di bulk_extractor riuscita...");
                bulkextractor = true;

                await setMessageState("Sto analizzando il dump, metitti comodo, ci vorrà un po!", "Sto eseguendo grep...");

                GrepResponse memdumpGrepResponse = await MemdumpGrepServices.grep(request);

                if(!memdumpGrepResponse.isBlank){
                  await setMessageState("Analisi del dump conclusa, analizzo il pagefile!", "Esecuzione di grep riuscita...");
                  memdumpGrep = true;


                  await setMessageState("Sto analizzando il pagefile, manca poco", "Sto eseguendo grep...");

                  GrepResponse pagefileGrepResponse = await PagefileGrepServices.grep(request);

                  if(!pagefileGrepResponse.isBlank){
                    await setMessageState("Analisi del pagefile conclusa, ho quasi finito!", "Esecuzione di grep riuscita...");
                    pagefileGrep = true;

                    //Controllo ulteriormente che tutte le chiamate siano andate a buon fine
                    if(pslist && netscan && filescan && timeliner && bulkextractor && memdumpGrep && pagefileGrep) {
                      await setMessageState("Ho finito!", "Sto formattando gli output ottenuti, ci vorrà ancora qualche secondo");
              

                      Map<String,VolatilityResponse> parsedVolatilityResponses = Map();
                      
                      //Faccio il parsing degli output in base alle keywords
                      parsedVolatilityResponses["pslist"] =  VolatilityResponse.parsePslistKeywords(allVolatilityResponses["pslist"], request.keywordsArray);
                      if(request.os == "windows"){
                        parsedVolatilityResponses["netscan"] =  VolatilityResponse.parseNetscanArguments(allVolatilityResponses["netscan"], request.keywordsArray, request.ipArray);
                        parsedVolatilityResponses["filescan"] =  VolatilityResponse.parseFilescanArguments(allVolatilityResponses["filescan"], request.keywordsArray);
                      }
                      parsedVolatilityResponses["timeliner"] =  VolatilityResponse.parseTimelinerKeywords(allVolatilityResponses["timeliner"], request.keywordsArray);

                      //Controllo che il parsing sia andato a buon fine
                      if(parsedVolatilityResponses.isNotEmpty) {
                        Navigator.pushNamed( //Mando gli output parsati alla pagina che dovrà mostrarli
                          context, "/resultsPage",
                          arguments: {
                            "volatility": parsedVolatilityResponses,
                            "bulk": beRes,
                            "memdumpGrep": memdumpGrepResponse,
                            "pagefileGrep": pagefileGrepResponse,
                          }
                        ); 
                      } else {
                        //Caso in cui il parsing non è andato a buon fine
                        await setMessageState("Nono sono stati trovati riscontri con le keyword inserite", "Naviga indietro e riprova");
                
                      }
                    } else {
                      //Caso in cui l'esecuzione di uno dei tool non è andata a buon fine
                      await setMessageState("Si è verificato un errore nell'esecuzione dei tools","Riprova più tardi");
              
                    }
                  } else {
                    //Caso in cui grep sul pagefile non è andato a buon fine
                    await setMessageState("Errore nell'esecuzione di grep sul pagefile!", "Riprova");
                  }
                } else {
                  //Caso in cui grep sul memdump non è andato a buon fine
                  await setMessageState("Errore nell'esecuzione di grep sul memdump!", "Riprova");
                }
              } else {
              //Caso in cui bulk non è andato a buon fine
              await setMessageState("Errore nell'esecuzione di bulk_extractor!", "Riprova");
              }
            }else {
              //Caso in cui timeliner non è andato a buon fine
              await setMessageState("Errore nell'esecuzione di timeliner!", "Riprova");
            }
          } else {
            //Caso in cui filescan non è andato a buon fine
            await setMessageState("Errore nell'esecuzione di filescan!", "Riprova");
    
          }
        } else {
          //Caso in cui netscan non è andato a buon fine
          await setMessageState("Errore nell'esecuzione di netscan!", "Riprova");
  
        }
      } else {
        //Caso in cui pslist non è andato a buon fine
        await setMessageState("Errore nell'esecuzione di pslist!", "Riprova");

      }
    } else {
      //Caso in cui non sono riuscito a recuperare le keywords
      await setMessageState("Si è verificato un errore nel recupero delle informazioni","Naviga indietro e riprova");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () => Navigator.pop(context),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(loadingMessage, style: TextStyle(color: fromHex("#00A4CE"), fontSize: 20)),
            Container(padding: EdgeInsets.all(10),),
            CircularProgressIndicator(),
            Container(padding: EdgeInsets.all(10),),
            Text(executingMessage, style: TextStyle(color: fromHex("#00A4CE"), fontSize: 20)),
          ],
        ),
      ),
    );
  }
}