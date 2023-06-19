import *  as express from "express";
import * as mongoose from "mongoose";
 import authController from "./controller/auth_controller";
 import gymController from "./controller/gym_contoller";
 import print from "./common/logger"
import athleteController from "./controller/athlete_controller";
import * as multer from 'multer'
import * as path from "path";
import payment_controller from "./controller/payment_controller";

const app = express();
app.use('/uploads', express.static(path.join(__dirname, '../uploads')));

app.use(express.urlencoded({ extended: true }));

app.use(express.json());


// type DestinationCallback = (error: Error | null, destination: string) => void
// type FileNameCallback = (error: Error | null, filename: string) => void 
app.listen(3000, () => {
    print("Server running on port 3000");
 
}   );
mongoose.connect('mongodb://127.0.0.1:27017/gym' ).then(() => {
    print("Connected to MongoDB");
  }).catch((err) => {
    print(err)
  });
  export const fileStorage = multer.diskStorage({
    destination: (
        request: any,
        file: any,
        callback: any
    ): void => {
      callback(null, 'uploads/');
    },

    filename: (
        req: any,
        file: any,
        callback: any,
    ): void => {
      callback(null, Date.now() + '-' + file.originalname);

    }
})
const upload = multer({ storage: fileStorage  })


 
  

  // auth routes
app.post('/auth/request-otp',authController.requestOtp);
app.post('/auth/verify-otp',authController.verifyOtp);

//gym
app.post('/gym',gymController.signUp);
app.get('/gym',gymController.gymInfo);
app.put('/gym',gymController.updateGym);


//athlete
app.post('/athlete', upload.single('profile'), athleteController.addAthlete);
app.get('/athletes',  athleteController.allAthletes);
app.get('/athlete',  athleteController.getAthlete);
app.delete('/athlete',  athleteController.deleteAthlete);
app.put('/athlete',  upload.single('profile'),athleteController.updateAthlete);


//payment 
app.post('/pay', payment_controller.pay);
app.post('/income', payment_controller.income);



