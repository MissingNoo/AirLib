import { db } from "./mongo.ts";
interface ScoreSchema {
    username: string;
    score : Number;
    data : string;
    timestamp : Number
}

const scores = db.collection<ScoreSchema>("Scores");

export function addScore(username:string, score : Number, data: string) {
    const now = new Date();
    const time = now.getTime();
    scores.insertOne({
        username : username,
        score : score,
        data : data,
        timestamp : time
    });
    console.log(username + " Submited a new score!");
}