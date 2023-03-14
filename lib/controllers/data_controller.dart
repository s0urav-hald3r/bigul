// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_constants.dart';
import '../screens/doc_fetch.dart';
import '../service/exception.dart';
import '../service/services.dart';

class DataController extends GetxController {
  final ApiProvider _apiProvider = ApiProvider();
  RxBool isLoading = false.obs;

  fetchDigiLockerData(BuildContext context) async {
    isLoading.value = true;
    try {
      dynamic response = await _apiProvider
          .post(AppConstants.baseUrl + AppConstants.digilockerData, {
        "mobile": 7566643335,
        "crn_number": "CRN220506185125353Y8",
        "response_id": "KID220506185125353AZE54OZ189LGAT",
        "response_action_id": "RID220506185125377I26QEXQE2CKCBI",
        "json_data": {
          "id": "KID220506185125353AZE54OZ189LGAT",
          "updated_at": "2022-05-06 18:53:40",
          "created_at": "2022-05-06 18:51:25",
          "status": "approval_pending",
          "customer_identifier": "shobhit.synetalsolutions@gmail.com",
          "actions": [
            {
              "id": "KIA220506185125378GRETR3HRIJLOTD",
              "action_ref": "digilocker-1",
              "type": "digilocker",
              "status": "success",
              "execution_request_id": "RID220506185125377I26QEXQE2CKCBI",
              "details": {
                "aadhaar": {
                  "id_number": "xxxxxxxx6355",
                  "document_type": "aadhaar",
                  "id_proof_type": "ID_AND_ADDRESS_PROOF",
                  "gender": "M",
                  "image":
                      "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",
                  "name": "Shobhit Gangrade",
                  "dob": "01/11/1995",
                  "current_address":
                      "C/O: Lakhan Lal Gangrade,Ward N.5,Gandhi Chouk,Gandhi Ke Chouk Pass,Borgaon Buzurg,Khandwa,Madhya Pradesh,450337",
                  "permanent_address":
                      "C/O: Lakhan Lal Gangrade,Ward N.5,Gandhi Chouk,Gandhi Ke Chouk Pass,Borgaon Buzurg,Khandwa,Madhya Pradesh,450337",
                  "current_address_details": {
                    "address":
                        "C/O: Lakhan Lal Gangrade,Ward N.5,Gandhi Chouk,Gandhi Ke Chouk Pass,Borgaon Buzurg,Khandwa,Madhya Pradesh,450337",
                    "locality_or_post_office": "Borgaon Buzurg",
                    "district_or_city": "Khandwa",
                    "state": "Madhya Pradesh",
                    "pincode": "450337"
                  },
                  "permanent_address_details": {
                    "address":
                        "C/O: Lakhan Lal Gangrade,Ward N.5,Gandhi Chouk,Gandhi Ke Chouk Pass,Borgaon Buzurg,Khandwa,Madhya Pradesh,450337",
                    "locality_or_post_office": "Borgaon Buzurg",
                    "district_or_city": "Khandwa",
                    "state": "Madhya Pradesh",
                    "pincode": "450337"
                  }
                },
                "pan": {
                  "id_number": "LBBPS5478K",
                  "document_type": "pan",
                  "id_proof_type": "ID_PROOF",
                  "gender": "M",
                  "name": "SHOBHIT",
                  "dob": "01/11/1995"
                }
              },
              "validation_result": {},
              "completed_at": "2022-05-06 18:52:57",
              "face_match_obj_type": "source",
              "face_match_status": "new",
              "obj_analysis_status": "na",
              "processing_done": false
            },
            {
              "id": "KIA220506185125389X6VD1IFNLUEI2K",
              "action_ref": "selfie-1",
              "type": "selfie",
              "status": "success",
              "file_id": "FIL220506185339293GMVYW3QDK9YUFS",
              "face_match_result": {
                "match_result": "matched",
                "confidence": 99
              },
              "sub_actions": [
                {
                  "id": "KSA2205061851253962PP1KPWGVHR6HX",
                  "type": "GEO_TAGGING",
                  "status": "success",
                  "details": {
                    "address":
                        "Building Business Park , 2nd Floor, Above SBI Bank , Kanadiya Road Add2 Amit Chambers Near Pooja Dairy, MY Main Road, Swami Vivekanand Nagar, Indore, Madhya Pradesh 452016, India",
                    "latitude": 22.720673,
                    "accuracy": 15.315,
                    "longitude": 75.9039541
                  },
                  "optional": false,
                  "actioner": "USER",
                  "input_data":
                      "{\"latitude\":22.720673,\"longitude\":75.9039541,\"accuracy\":15.315,\"address\":\"Building Business Park , 2nd Floor, Above SBI Bank , Kanadiya Road Add2 Amit Chambers Near Pooja Dairy, MY Main Road, Swami Vivekanand Nagar, Indore, Madhya Pradesh 452016, India\"}",
                  "obj_analysis_status": "na",
                  "face_match_obj_type": "none",
                  "face_match_status": "na"
                }
              ],
              "validation_result": {
                "LIVENESS_CHECK": {
                  "score": 0.9466744661331177,
                  "result": "PASS"
                }
              },
              "completed_at": "2022-05-06 18:53:39",
              "face_match_obj_type": "strict_match_required",
              "face_match_status": "done",
              "obj_analysis_status": "na",
              "method": "otp_none",
              "processing_done": false
            }
          ],
          "reference_id": "CRN220506185125353Y8",
          "request_details": {},
          "transaction_id": "CRN220506185125353Y8",
          "customer_name": "SHOBHIT",
          "expire_in_days": 10,
          "reminder_registered": false,
          "workflow_name": "TESTDIGILOCKER"
        }
      });
      if (response != null) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Dialog(
                  backgroundColor: Colors.white,
                  insetPadding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: DocFetch(),
                ));
      }
    } catch (e) {
      if (e is CustomException) {
        Get.snackbar(
          "Error",
          e.getMessage(),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }
}
