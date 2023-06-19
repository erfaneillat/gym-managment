

import { Schema,model} from 'mongoose';

const paymentSchema = new Schema({
    gymId : {type: Schema.Types.ObjectId, ref: 'Gym'},
    athleteId : {type: Schema.Types.ObjectId, ref: 'Athlete'},
    amount: Number,
  }, { timestamps: true });

  const Payment = model('Payment', paymentSchema);


  
  export default Payment;