import { InferSchemaType, model, Schema } from "mongoose";

const ComicAlbumSchema = new Schema({
    albumName: {type: String},
    comicList: {type: Array},
});

type ComicAlbum = InferSchemaType<typeof ComicAlbumSchema>;

export default model<ComicAlbum>("comicAlbum", ComicAlbumSchema);