

import { Schema,model} from 'mongoose';

const gymSchema = new Schema({
    phoneNumber: String,
    nameAndFamily: String,
    gymName: String,
    athleteCount: Number,
    otp: String,
    gymFee:Number
  }, { timestamps: true });

  const Gym = model('Gym', gymSchema);
  export default Gym;