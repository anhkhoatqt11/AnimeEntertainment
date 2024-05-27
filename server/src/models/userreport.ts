import mongoose, { InferSchemaType, model, Schema } from "mongoose";

const userReportSchema = new Schema({
  reportContent: { type: String },
  reportTime: { type: Date },
  userBeReportedId: { type: mongoose.Types.ObjectId },
  userReportedId: { type: mongoose.Types.ObjectId },
  type: { type: String },
  destinationId: { type: mongoose.Types.ObjectId },
  commentId: { type: mongoose.Types.ObjectId },
  status: { type: String },
});

type UserReport = InferSchemaType<typeof userReportSchema>;

export default model<UserReport>("UserReport", userReportSchema);