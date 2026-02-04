import 'package:flutter/material.dart';
import 'package:hackathon/ui/setup_your_home_screen.dart';
import 'package:hackathon/ui/widgets/base_scaffold.dart';
import 'package:hackathon/ui/widgets/primary_button.dart';
import 'package:hackathon/ui/styles.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: double.infinity),
            CircleAvatar(radius: 55, child: Icon(Icons.cell_wifi, size: 50,),),
        
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Text("Wi-Fi Signal\nAnalyzer", textAlign: TextAlign.center, style: textStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 22,),),
            ),
             SizedBox(
              width: 300,
              child: Text("Map weak spots in your home and get AI-powered recommendations for optimal coverage", textAlign: TextAlign.center, style: textStyle.copyWith( fontSize: 18, color: Colors.grey.shade700),)),
              
              Padding(
                padding: const EdgeInsets.only(top:  40.0),
                child: SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder:(context) => SetupYourHomeScreen()));
                  }, label: "Get Started" )),
              )
        
          ],
        ),
      ),
    );
  }
}