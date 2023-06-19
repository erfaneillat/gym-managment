

import { Schema,model} from 'mongoose';

const athleteSchema = new Schema({
    gymId : {type: Schema.Types.ObjectId, ref: 'Gym'},
  nameAndFamily: String,
  profileImage: String,
  phoneNumber: String,
  nationalCode: String,
  fatherName: String,
  description: String,
  registerInGymDate: Date,
  lastPayment: Date,
  haveInsurance: Boolean,
  insuranceStart: Date,
  insuranceEnd :Date,
  registeredEveryOtherDay :Boolean
  }, { timestamps: true });

  const Athlete = model('Athlete', athleteSchema);
  export default Athlete;