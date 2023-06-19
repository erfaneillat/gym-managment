

import error from "../common/error"
import Gym from "../model/gym";
import response from "../common/response";
const requestOtp = async (req: any, res: any, next: any) => {
  const { phoneNumber } = req.body;
  try {
    const gym = await Gym.findOne({ phoneNumber: phoneNumber });
    if (gym) {
      gym.set({ otp: '1111' });
      await gym.save();
      response.successResponse(res, 200, { id: gym._id });

    } else {
      new Gym({
        phoneNumber: phoneNumber,
        otp: '1111'
      }).save().then((result: any) => {
        response.successResponse(res, 200, { id: result._id });
      }).catch((err: any) => {
        response.errorResponse(res, 400, error.UNEXPECTED_ERROR);
      });
    }
  } catch (e) {
    response.errorResponse(res, 400, error.UNEXPECTED_ERROR);

  }



};

const verifyOtp = async (req: any, res: any, next: any) => {

  try {
    const { phoneNumber, code } = req.body;

    const gym = await Gym.findOne({ phoneNumber: phoneNumber });
    if (!gym) {
      return response.errorResponse(res, 400, error.USER_NOT_FOUND);
    }

    if (code !== gym.otp) {
      return response.errorResponse(res, 400, error.WRONG_OTP);
    }

    if (gym.gymName == null || gym.nameAndFamily == null || gym.gymFee == null) {
      return response.successResponse(res, 200, { id: gym._id, completedProfile: false });
    }

    return response.successResponse(res, 200, { id: gym._id, completedProfile: true });
  } catch (e) {
    return response.errorResponse(res, 400, error.UNEXPECTED_ERROR);
  }


};


export default { requestOtp, verifyOtp }