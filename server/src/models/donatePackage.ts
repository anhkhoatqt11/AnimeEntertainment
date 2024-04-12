import { InferSchemaType, model, Schema } from "mongoose";

const donatePackagesSchema = new Schema({
  coverImage: { type: String },
  title: { type: String },
  subTitle: { type: String },
  donateRecords: { type: Array },
  coin: { type: Number },
});

type DonatePackages = InferSchemaType<typeof donatePackagesSchema>;

export default model<DonatePackages>("DonatePackages", donatePackagesSchema);
