import { InferSchemaType, model, Schema } from "mongoose";

const userSchema = new Schema({
    username: {type: String, required: true},
    email: {type: String, required: true},
    authentication: {
        password: {type: String, required: true, select: false},
        salt: {type: String, select: false},
        sessionToken: {type: String, select: false}
    },
    avatar: {type: String},
    coinPoint: {type: String},
    bookmarkList: {
        comic: {type: Array},
        movies: {type: Array},
    },
    histories: {
        readingComic: {type: Array},
        watchingMovie:{type: Array},
    },
    paymentHistories: {type: Array},

});

type User = InferSchemaType<typeof userSchema>;

export default model<User>("User", userSchema);
