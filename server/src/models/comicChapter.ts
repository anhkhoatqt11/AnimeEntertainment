import { InferSchemaType, model, Schema } from "mongoose";

const comicChaptersSchema = new Schema({
    coverImage: {type: String},
    chapterName: {type: String},
    publicTime: {type: Date},
    // *
    content: {type: Array},
    comments: {type: Array},
    likes: {type: String}, // id of likerecord
    views: {type: Number},
    unlockPrice: {type: Number},
    userUnlocked: {type: Array},
});

type ComicChapters = InferSchemaType<typeof comicChaptersSchema>;

export default model<ComicChapters>("comicChapters", comicChaptersSchema);