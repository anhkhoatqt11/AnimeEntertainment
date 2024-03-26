import { InferSchemaType, model, Schema } from "mongoose";

const animeSchema = new Schema({
    coverImage: {type: String},
    landspaceImage: {type: String},
    movieName: {type: String},
    genres: {type: Array},
    publishTime: {type: String},
    ageFor: {type: String},
    publisher: {type: String},
    description: {type: String},
    episodes: {type: Array}
   

});

type Anime = InferSchemaType<typeof animeSchema>;

export default model<Anime>("Anime", animeSchema);
