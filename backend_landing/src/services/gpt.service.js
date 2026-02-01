import OpenAI from "openai";
const client = new OpenAI({ apiKey: process.env.OPENAI_KEY });

export const getRecommendation = async (answers) => {
  const prompt = `이 온보딩 데이터를 기반으로 행동 추천:
  ${JSON.stringify(answers)}`;

  const res = await client.chat.completions.create({
    model: "gpt-4o-mini",
    messages: [{ role: "user", content: prompt }],
  });

  return res.choices[0].message.content;
};