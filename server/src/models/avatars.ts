import { InferSchemaType, model, Schema } from "mongoose";

const avatarsSchema = new Schema({
  collectionName: { type: String },
  avatarList: { type: Array },
});

type Avatars = InferSchemaType<typeof avatarsSchema>;

export default model<Avatars>("Avatars", avatarsSchema);
