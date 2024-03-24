import { InferSchemaType, model, Schema } from "mongoose";

const bannersSchema = new Schema({
    type: {type: String},
    list: {type: Array},
});

type Banners = InferSchemaType<typeof bannersSchema>;

export default model<Banners>("Banners", bannersSchema);