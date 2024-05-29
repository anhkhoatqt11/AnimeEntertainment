import { InferSchemaType, model, Schema } from "mongoose";

const challengesSchema = new Schema({
  challengeName: { type: String },
  endTime: { type: Date },
  questionCollection: { type: Array },
});

type Challenges = InferSchemaType<typeof challengesSchema>;

export default model<Challenges>("Challenges", challengesSchema);
