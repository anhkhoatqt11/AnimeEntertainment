import { InferSchemaType, model, Schema } from "mongoose";

const dailyQuestsSchema = new Schema({
  questType: { type: String },
  questName: { type: String },
  prize: { type: Number },
  requiredTime: { type: Number },
});

type DailyQuests = InferSchemaType<typeof dailyQuestsSchema>;

export default model<DailyQuests>("DailyQuest", dailyQuestsSchema);
