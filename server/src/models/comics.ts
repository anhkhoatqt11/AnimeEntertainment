import { InferSchemaType, model, Schema } from "mongoose";

const comicsSchema = new Schema({
    coverImage: {type: String},
    lanspaceImage: {type: String},
    comicName: {type: String},
    author: {type: String},
    artist: {type: String},
    genres: {type: Array},
    ageFor: {type: String},
    publisher: {type: String},
    description: {type: String},
    newChapterTime: {type: String},
    chapterList: {type: Array},
});

type Comics = InferSchemaType<typeof comicsSchema>;

export default model<Comics>("Comics", comicsSchema);