import { InferSchemaType, model, Schema } from "mongoose";

const animeEpisodesSchema = new Schema({
    coverImage: {type: String},
    episodeName: {type: String},
    totalTime: {type: Number},
    publicTime: {type: Date},
    // *
    content: {type: String},
    comments: {type: Array},
    likes: {type: Array}, // list of user liked
    views: {type: Number},
    advertising: {type: String},
    adLink: {type: String},
});

type AnimeEpisodes = InferSchemaType<typeof animeEpisodesSchema>;

export default model<AnimeEpisodes>("animeEpisodes", animeEpisodesSchema);