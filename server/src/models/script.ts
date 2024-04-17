//this is temporary database script
interface Users {
    _id: string,
    // *
    avatar: string,
    userName: string,
    coinPoint: number,
    bookmarkList: {
        comic: [
            // ObjectId("example"); id cua comic chapter
            // percentTime
        ],
        movies: [

        ]
    },
    histories: {
        readingComic: [

        ],
        watchingMovie: [
            
        ]
    },
    paymentHistories: []
}

interface Comics {
    _id: string,
    //*
    coverImage: string,
    landspaceImage: string,
    comicName: string,
    author: string,
    artist: string,
    genres: [
        // *
        // 1 comic has duplicate genres and 1 genre has many comics
        // list id of genres
    ],
    ageFor: string,
    publisher: string,
    description: string,
    newChapterTime: string,
    chapterList: [
        // use references
        // list id of comic chapter
    ],
    

}

interface ComicChapters {
    _id: string,
    //*
    coverImage: string,
    chapterName: string,
    publicTime: string,
    // *
    content: string,
    comments: [
        {
            // *
            userId: string,
            content: string,
            likes: [
                //list id of users have likes this comment
            ],
            replies: [
                {
                    userId: string,
                    content: string,
                    likes: [

                    ],
                    replies: [

                    ]
                }
            ]
        }
    ],
    likes: [
        // list of id user
    ], // id of likerecord
    views: number,
    unlockPrice: number,
    userUnlocked: [
        // this helps us configure top unlock of week or month
    ]
}

interface AnimeMovies {
    _id: string,
    // *
    coverImage: string,
    landspaceImage: string,
    movieName: string,
    genres: [
        // list id of genres
    ],
    publishTime: string,
    ageFor: string,
    publisher: string,
    description: string,
    episodes: [
        // list id of episodes
    ]
}


interface AnimeEpisodes {
    _id: string,
    // *
    coverImage: string,
    episodeName: string,
    totalTime: string,
    // *
    content: string,
    likes: [
        // list of id user
    ], // id of likerecord
    views: number,
    publishTime: string,
    comments: [
        {
            // *
            userId: string
            likes: [
                //list id of users have likes this comment
            ],
            replies: [
                {
                    userId: string,
                    likes: [

                    ],
                    replies: [

                    ]
                }
            ]
        }
    ],
    // *
    advertisement: string,
}

interface Genres {
    _id: string,
    genreName: string,

}

interface ComicAlbum {
    _id: string,
    albumName: string,
    comicList: []
}

interface DonatePackage {
    _id: string,
    packageName: string,
    packageValue: number,
}

interface Banners {
    _id: string,
    type: string,
    list: [
        {
            bannerImage: string,
            urlId: string,
        }
    ]
}


// these below may be used but not corrected, just some function, task owner create the rest, thank u~~~~
interface PaymentHistory {
    // * task owner create this
}

interface DonateRanking {

}


interface AnimeAlbum {

}
interface HomeBanner {

}
interface HotSeries {

}

