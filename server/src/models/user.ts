import { InferSchemaType, model, Schema } from "mongoose";

const userSchema = new Schema({
    name: {type: String},
    phoneNumber: {type: String},
    total: {type: Number},
    payed: {type: Number},
    debt: {type: Number}
});

type User = InferSchemaType<typeof userSchema>;

export default model<User>("User", userSchema);