import { InferSchemaType, model, Schema } from "mongoose";


const questionsSchema = new Schema({
    questionName : {type: String},
    answers: {type: Array},
    correctAnswerID: {type: Number},
    mediaUrl: {type: String},
});

type Questions = InferSchemaType<typeof questionsSchema>;

export default model<Questions>("Questions", questionsSchema);