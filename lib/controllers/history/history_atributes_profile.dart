import 'package:app/models/atributes_profile_model.dart';
import 'package:app/utils/app_debug_reports.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AtributeProfileController extends GetxController {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  late AtributeProfile currentAtribute;

  void setAtributeProfile(AtributeProfile newAtributeProfile) {
    currentAtribute = newAtributeProfile;
  }

  Future<void> createAtributesProfile(AtributeProfile atributesProfile) async {
    try {
      //Future<DocumentReference<Map<String,dynamic>>> atribute = db.collection('atributes').add(atributesProfile.toMap());
     await db.collection('atributes').add(atributesProfile.toMap());
    } catch (error) {
      logger.e(error);
    }
  }

  Future<bool> existAtributeProfile(String userid) async {
        try { 
        var querySnapshot  = await db.collection('atributes').where("iduser",isEqualTo: userid).get();
        
        if (querySnapshot.docs.isEmpty) {
          var docSnapshot = querySnapshot.docs.first; 
          var atributeProfile = AtributeProfile.fromJson(docSnapshot.data());
          setAtributeProfile(atributeProfile);
          return false;
        } else {
          return true;
        }

    } catch (error) {
      logger.e(error);
    }
    return false;
  }

  Future<void> getAtributeProfile(String userid) async {
    try { 
      var querySnapshot  = await db.collection('history').where("iduser",isEqualTo: userid).get();
      
      if (querySnapshot.docs.isNotEmpty) {
        var docSnapshot = querySnapshot.docs.first; 

        var atributeProfile = AtributeProfile.fromJson(docSnapshot.data());
        setAtributeProfile(atributeProfile);
      } else {
        throw Exception("No se ha encontrado el atributo del perfil actual");
      }

    } catch (error) {
      logger.e(error);
    }
  }



  Future<void> deleteAtributesProfile(String userid) async {
    try {
      await db.collection('atributes').doc(userid).delete();
    } catch (error) {
      logger.e(error);
    }
  }

  Future<void> updateAtributesProfile(AtributeProfile atributesProfile) async {
    try {
      await db.collection('atributes').doc(currentAtribute.userid).update(atributesProfile.toMap());
    } catch (error) {
      logger.e(error);
    }
  }

}