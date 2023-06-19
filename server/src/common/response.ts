



const successResponse = (res: any, status?: number, result?: any) => {
    return res.status(status || 200).json({
        message:"ok", result: result
    });
};
const errorResponse = (res: any, status?: number, error?:string) => {
    return res.status(status || 400).json({
        error:error|| 'Bad Request',
    });
};

export default {successResponse,errorResponse}