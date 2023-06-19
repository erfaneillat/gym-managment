
import mongoose from "mongoose";
import error from "../common/error";
import response from "../common/response";
import Payment from "../model/payment";
import Gym from "../model/gym";
import Athlete from "../model/athlete";
import * as  moment from 'jalali-moment';


const pay = async (req: any, res: any, next: any) => {

    try {
        const { athleteId, gymId } = req.body;
        const gym = await Gym.findOne({ _id: gymId }).select({ gymFee: 1 });
        if (!gym) {
            return response.errorResponse(res, 400, error.USER_NOT_FOUND);
        }
        const payment = await new Payment({
            gymId: new mongoose.Types.ObjectId(gymId),
            athleteId: new mongoose.Types.ObjectId(athleteId),
            amount: gym!.gymFee
        }).save()

        await Athlete.findByIdAndUpdate(athleteId, { lastPayment: Date.now() })





        return response.successResponse(res, 200, { id: payment._id });
    } catch (e) {
        return response.errorResponse(res, 400, error.UNEXPECTED_ERROR);
    }


};

const income = async (req: any, res: any, next: any) => {


    try {

        const jalaliYear = moment().jYear()


        const incomeByMonth = await Promise.all(
            Array.from({ length: 12 }, async (_, month) => {
                const startDate = moment().clone().jYear(jalaliYear).jMonth(month).startOf('jMonth').toDate()
                const endDate = moment().clone().jYear(jalaliYear).jMonth(month+1).startOf('jMonth').toDate()
          
                const result = await Payment.aggregate([
                    {
                        $match: {
                            createdAt: { $gte: startDate, $lte: endDate }
                        }
                    },
                    {
                        $group: {
                            _id: new mongoose.Types.ObjectId('6482f4e34173ee022fc11a68'),
                            totalIncome: { $sum: '$amount' }
                        }
                    }
                ]).exec();

                return {
                    date:moment(endDate),
                    income: result.length ? result[0].totalIncome : 0,
                    // jalaliDate: jalaliYear.jMonth(month).format('jYYYY/jMM/jDD')
                };
            })
        );


        return response.successResponse(res, 200, incomeByMonth);
    } catch (e) {
        return response.errorResponse(res, 400, error.UNEXPECTED_ERROR);
    }

}
export default { pay, income }