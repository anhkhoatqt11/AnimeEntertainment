import { InferSchemaType, model, Schema } from "mongoose";

const userSchema = new Schema({
  username: { type: String },
  phone: { type: String },
  authentication: {
    password: { type: String, select: false },
    salt: { type: String, select: false },
    sessionToken: { type: String, select: false },
  },
  avatar: { type: String },
  coinPoint: { type: Number },
  bookmarkList: {
    comic: { type: Array },
    movies: { type: Array },
  },
  histories: {
    readingComic: { type: Array },
    watchingMovie: { type: Array },
  },
  paymentHistories: { type: Array },
  challenges: { type: Array },
  questLog: { type: Object },
  accessCommentDate: { type: Date },
  notifications: { type: Array },
  deviceToken: { type: String },
});

type User = InferSchemaType<typeof userSchema>;

export default model<User>("User", userSchema);