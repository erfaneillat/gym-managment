





import mongoose from "mongoose";
import error from "../common/error"
import response from "../common/response";
import Athlete from "../model/athlete";
import Gym from "../model/gym";
import Payment from "../model/payment";
const addAthlete = async (req: any, res: any, next: any) => {
    const file = req.file;
    let imageUrl;
    if (file) {
        imageUrl = `/uploads/${file.filename}`;
    }

    const { id, nameAndFamily, phoneNumber, nationalCode, fatherName, description, lastPayment, registerInGymDate, haveInsurance, insuranceStart, insuranceEnd, registeredEveryOtherDay } = req.body;
    try {
        const a = await new Athlete({
            gymId: new mongoose.Types.ObjectId(id),
            nameAndFamily: nameAndFamily,
            phoneNumber: phoneNumber,
            profileImage: imageUrl,
            nationalCode: nationalCode,
            fatherName: fatherName,
            description: description,
            lastPayment: Date.parse(lastPayment),
            registerInGymDate: Date.parse(registerInGymDate),
            haveInsurance: haveInsurance,
            insuranceStart: insuranceStart ? Date.parse(insuranceStart) : null,
            insuranceEnd: insuranceEnd ? Date.parse(insuranceEnd) : null,
            registeredEveryOtherDay: registeredEveryOtherDay

        }).save();
        const gym = await Gym.findByIdAndUpdate(id, { $inc: { athleteCount: 1 } });
        await new Payment({
            gymId: new mongoose.Types.ObjectId(id),
            athleteId: new mongoose.Types.ObjectId(a._id),
            amount: gym!.gymFee
        }).save()
        return response.successResponse(res, 200, a);
    } catch (e) {
        console.log(e);

        response.errorResponse(res, 400, error.UNEXPECTED_ERROR);

    }

};
const allAthletes = async (req: any, res: any, next: any) => {

    const { id, page, name } = req.query;


    try {
        const athletes = await Athlete.find({ gymId: new mongoose.Types.ObjectId(id), nameAndFamily: { $regex: '^' + name, $options: 'i' } }).skip((page - 1) * 15).limit(15).select({ nameAndFamily: 1, lastPayment: 1, profileImage: 1, description: 1 });
        return response.successResponse(res, 200, { page: page, athletes: athletes });
    } catch (e) {
        console.log(e);

        response.errorResponse(res, 400, error.UNEXPECTED_ERROR);

    }

};
const getAthlete = async (req: any, res: any, next: any) => {

    const { id } = req.query;
    console.log(id);



    try {
        const athlete = await Athlete.findById(id);
        return response.successResponse(res, 200, athlete);
    } catch (e) {
        console.log(e);

        response.errorResponse(res, 400, error.UNEXPECTED_ERROR);

    }

};
const deleteAthlete = async (req: any, res: any, next: any) => {

    const { id } = req.query;




    try {
        const athlete = await Athlete.findByIdAndDelete(id);

        await Gym.findByIdAndUpdate(athlete?.gymId, { $inc: { athleteCount: -1 } });

        return response.successResponse(res, 200, {});
    } catch (e) {
        console.log(e);

        response.errorResponse(res, 400, error.UNEXPECTED_ERROR);

    }

};
const updateAthlete = async (req: any, res: any, next: any) => {
    const file = req.file;
    let imageUrl;
    if (file) {
        imageUrl = `/uploads/${file.filename}`;
    }

    const { id, nameAndFamily, phoneNumber, nationalCode, fatherName, description, lastPayment, registerInGymDate, haveInsurance, insuranceStart, insuranceEnd, registeredEveryOtherDay } = req.body;
    console.log(req.body);

    try {
        await Athlete.findByIdAndUpdate(id, {
            nameAndFamily: nameAndFamily,
            phoneNumber: phoneNumber,
            profileImage: imageUrl,
            nationalCode: nationalCode,
            fatherName: fatherName,
            description: description,
            lastPayment: Date.parse(lastPayment),
            registerInGymDate: Date.parse(registerInGymDate),
            haveInsurance: haveInsurance,
            insuranceStart: insuranceStart ? Date.parse(insuranceStart) : null,
            insuranceEnd: insuranceEnd ? Date.parse(insuranceEnd) : null,
            registeredEveryOtherDay: registeredEveryOtherDay

        })

        return response.successResponse(res, 200, {});
    } catch (e) {
        console.log(e);

        response.errorResponse(res, 400, error.UNEXPECTED_ERROR);

    }

};
export default { addAthlete, allAthletes, getAthlete, deleteAthlete, updateAthlete }