import { InferSchemaType, model, Schema } from "mongoose";

const AnimeAlbumSchema = new Schema({
    albumName: {type: String},
    animeList: {type: Array},
});

type AnimeAlbum = InferSchemaType<typeof AnimeAlbumSchema>;

export default model<AnimeAlbum>("animeAlbum", AnimeAlbumSchema);