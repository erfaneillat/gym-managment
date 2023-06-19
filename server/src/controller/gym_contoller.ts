import mongoose from "mongoose";
import error from "../common/error";
import response from "../common/response";
import Athlete from "../model/athlete";
import Gym from "../model/gym";

const signUp = async (req: any, res: any, next: any) => {

  try {
    const { id, nameAndFamily, gymName, gymFee } = req.body;

    const gym = await Gym.findOne({ _id: id });
    if (!gym) {
      return response.errorResponse(res, 400, error.USER_NOT_FOUND);
    }
    await gym.set({
      nameAndFamily: nameAndFamily,
      gymName: gymName,
      gymFee: gymFee
    }).save()

    await new Athlete({
      gymId: new mongoose.Types.ObjectId(id),
      nameAndFamily: 'ورزشکار آزمایشی',
      phoneNumber: '09123456789',
      nationalCode: '1234567890',
      fatherName: 'پدر ورزشکار آزمایشی',
      description: 'توضیحات ورزشکار آزمایشی',
      lastPayment: Date.now(),
      registerInGymDate: Date.now(),
      haveInsurance: false,
      registeredEveryOtherDay: false

    }).save();
    await Gym.findByIdAndUpdate(id, { $inc: { athleteCount: 1 } });

    return response.successResponse(res, 200, { id: gym._id });
  } catch (e) {
    return response.errorResponse(res, 400, error.UNEXPECTED_ERROR);
  }


};

const gymInfo = async (req: any, res: any, next: any) => {

  try {
    const { id } = req.query;

    const gym = await Gym.findOne({ _id: id }).select({ otp: 0 });

    return response.successResponse(res, 200, gym);
  } catch (e) {
    return response.errorResponse(res, 400, error.UNEXPECTED_ERROR);
  }


};

const updateGym = async (req: any, res: any, next: any) => {

  try {
    const { id, nameAndFamily, gymName, gymFee } = req.body;

    const gym = await Gym.findOneAndUpdate(new mongoose.Types.ObjectId(id), {
      nameAndFamily: nameAndFamily,
      gymName: gymName,
      gymFee: gymFee
    });



    return response.successResponse(res, 200, { id: gym?._id });
  } catch (e) {
    console.log(e);
    
    return response.errorResponse(res, 400, error.UNEXPECTED_ERROR);
  }


};
export default { signUp, gymInfo, updateGym }