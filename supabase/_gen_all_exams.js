/* Generate migration 20260601000016_all_exams.sql for the remaining Mai Lan Hương
   Tenses sections (II–XIX, XXI–XXIV, excluding I/XX/XXV already seeded).
   Fill/conjugation/open => type 'text' (AI-graded). Choose-form/MCQ => 'mcq'.
   Multi-blank items kept whole; learner types answers separated by ';'.
   Run: node supabase/_gen_all_exams.js */
const fs = require("fs");
const esc = (s) => String(s).replace(/'/g, "''");
const L = ["A", "B", "C", "D"];

// id helper: pad a hex char block
const ids = {
  II: "a0000002", III: "a0000003", IV: "a0000004", V: "a0000005", VI: "a0000006",
  VII: "a0000007", VIII: "a0000008", IX: "a0000009", X: "a0000010", XI: "a0000011",
  XII: "a0000012", XIII: "a0000013", XIV: "a0000014", XV: "a0000015", XVI: "a0000016",
  XVII: "a0000017", XVIII: "a0000018", XIX: "a0000019", XXI: "a0000021", XXII: "a0000022",
  XXIII: "a0000023", XXIV: "a0000024",
};
const uuid = (h) => `${h}-0000-4000-8000-000000000000`;

// ---------------- TEXT sections (AI-graded). Each entry: [title, desc, level, [stems...]] ----------------
const TEXT = {
  II: ["Hiện tại đơn / tiếp diễn (hội thoại)", "Chia động từ trong ngoặc; AI chấm. Nhiều chỗ trống: gõ đáp án cách nhau bằng ';'. (bài II)", "TB", [
    "What ______ (you/ do)? — I ______ (write) to my parents. I ______ (write) to them every weekend.",
    "Look, it ______ (snow). — It ______ (not snow) in my country.",
    "Where ______ (he/ live)? ______ (you/ know)? — He ______ (live) in Milan, but now he ______ (stay) with his aunt.",
    "What time ______ (you/ usually/ finish) work? — Normally I ______ (finish) at five, but this week I ______ (work) until six.",
    "How ______ (you/ travel) to work? — I ______ (go) to work on the bus this week. Usually I ______ (drive).",
    "The sun ______ (rise) in the east, remember. It's behind us, so we ______ (travel) west.",
    "______ (you/ look) for someone? — Yes, I ______ (need) to speak to Neil. I ______ (think) he's busy. He ______ (talk) to the boss at the moment.",
    "I ______ (want) a new computer. I ______ (save) up to buy one. — But computers ______ (cost) so much. It ______ (get) out of date now.",
    "Your new dress ______ (look) very nice. — It ______ (not/ fit) properly. I ______ (not/ know) why I bought it.",
    "What ______ (you/ do)? — I ______ (taste) the sauce. It ______ (taste) too salty.",
    "I ______ (think) this road is dangerous. Look how fast that lorry ______ (go). — I ______ (agree).",
    "It seems they ______ (always/ fight) about something. — It will be better when they ______ (grow) up.",
    "I ______ (live) at a guest house at the moment as I ______ (look) for a flat. You'll have the goods by the end of the week, I ______ (promise).",
    "I ______ (always/ fall) asleep. — What time ______ (you/ go) to bed? — But it ______ (not/ make) any difference.",
    "Why ______ (you/ want) to change the whole plan? — And I ______ (not/ understand) why you ______ (be) so difficult about it.",
  ]],
  III: ["Hiện tại hoàn thành / HTHT tiếp diễn", "Chia động từ; AI chấm. (bài III)", "TB", [
    "How long ______ (you/ study) English? — I ______ (learn) English since I was twelve.",
    "I ______ (wait) for two hours, but my friend ______ (not come) yet.",
    "I ______ (lose) my address book. ______ (you/ see) it anywhere? — I ______ (just/ see) it on the bookshelf.",
    "______ (you/ work) so hard? — I ______ (study) for four hours and probably won't finish until midnight.",
    "______ (you/ see) Mark recently? — No, I ______ (not/ see) him since Christmas. I wonder where he ______ (live) since then.",
    "It's because you ______ (do) too much. — At least I ______ (finish) that report now.",
    "Someone ______ (leave) the ladder outside. — Mike ______ (clean) the windows. I don't think he ______ (finish) yet.",
    "I ______ (work) in the garden. — You ______ (do) a good job.",
    "I ______ (hear) that you are building a garage. How long ______ (you/ do) that? — We ______ (do) about half of it.",
    "How long ______ (you/ read) it? — I ______ (read) it for three days, but I ______ (not/ finish) it yet.",
    "How long ______ (you/ know) Jane? — We ______ (know) each other for over ten years.",
    "______ (John/ always/ live) in London? — No, he ______ (live) in London for the last few years.",
  ]],
  IV: ["Tổng hợp thì hiện tại", "Chia động từ; AI chấm. (bài IV)", "TB", [
    "Listen! I ______ (think) someone ______ (knock) at the door.",
    "We ______ (not/ know) why Sarah is upset, but she ______ (not/ speak) to us for ages.",
    "The earth ______ (circle) the sun once every 365 days.",
    "Why ______ (you/ stare) at me? I suppose you ______ (not/ see) a woman on a motorbike before!",
    "How many times ______ (you/ see) him since he went to Edinburgh?",
    "Trevor and Laura like Scrabble. They ______ (play) it most evenings.",
    "The number of vehicles on the road ______ (increase).",
    "'Sorry I'm late.' 'That's all right. I ______ (not/ wait) long.'",
    "Mrs Green always ______ (go) to work by car, but this week she ______ (travel) by bus.",
    "We ______ (be) from France. We ______ (be) there for 20 years.",
    "These flowers are dying. You ______ (not/ water) them for ages.",
    "Mai ______ (lose) her keys, so she can't get into the house.",
    "I ______ (not/ finish) typing those letters yet. I ______ (deal) with customers all morning.",
    "What ______ (your father/ do)? — He ______ (be) an architect but he ______ (not/ work) at the moment.",
    "______ (you/ ever/ see) a lion? — Yes, I ______ (see) one since I was a child.",
  ]],
  V: ["Điền đoạn văn — lá thư (HTHT / hiện tại)", "Điền động từ phù hợp vào đoạn văn; AI chấm. Gõ đáp án từng chỗ cách nhau bằng ';'. (bài V)", "K", [
    "We (be) ______ here for three days now and we (decide/plan) ______ to stay for the rest of the week because we (enjoy) ______ ourselves so much.",
    "We (see/visit) ______ the Cathedral and the Castle Museum and this morning we (walk/wander) ______ around the little old-fashioned streets.",
    "We (not/ spend) ______ much money yet but we'll get some souvenirs before we leave.",
    "Besides the sightseeing, we (do/get) ______ some exercise and we (go/have) ______ some lovely long walks.",
    "Fortunately, the weather (be) ______ very good so far. People (say/tell) ______ it can be very cold and it often (rain) ______ for days!",
    "As this is the first time I (be/come) ______ to England, I (think) ______ I'm just lucky.",
  ]],
  VI: ["Viết câu từ từ cho sẵn (quá khứ)", "Sắp xếp từ thành câu, dùng quá khứ đơn/tiếp diễn; AI chấm. (bài VI)", "TB", [
    "when Don / arrive / we / have / coffee",
    "he / sit down / on a chair / while / I / paint / it",
    "the students / play / a game / when / professor / arrive",
    "Felix / phone / the fire brigade / when the cooker / catch / fire",
    "while / he / walk / in the mountains / Henry / see / a bear",
    "when the starter / fire / his pistol / the race / begin",
    "I / walk / home / when it / start / to rain",
    "when / Margaret / open / the door / the phone / ring",
    "he / sit / in the garden / when / a wasp / sting / him / on the nose",
    "while / he / run / for a bus / he / collide / with a lamp post",
    "Vicky / have / a beautiful dream / when / the alarm clock / ring",
    "when / Alex / see / the question / he / know / the answer / immediately",
    "the train / wait / when / we / arrive / at the station",
    "Sarah / have / an electric shock / when / she / touch / the wire",
    "when / the campers / wake / they / see / the sun / shine",
  ]],
  VII: ["Quá khứ đơn / tiếp diễn", "Chia động từ; AI chấm. (bài VII)", "TB", [
    "When Martin ______ (arrive) home, Ann ______ (talk) to someone on the phone.",
    "It ______ (be) cold when we ______ (leave) the house, and a light snow ______ (fall).",
    "I ______ (call) Roger at nine last night, but he ______ (not/ be) at home. He ______ (study) at the library.",
    "I ______ (see) Sue in town yesterday but she ______ (not/ see) me. She ______ (look) the other way.",
    "When I ______ (open) the cupboard door, a pile of books ______ (fall) out.",
    "How ______ (you/ break) your arm? — I ______ (slip) on the ice while I ______ (cross) the street.",
    "What ______ (you/ do) this time yesterday? — We ______ (drive) to London, but on the way we ______ (hear) about a bomb scare. So we ______ (drive) back home.",
    "I ______ (meet) Tom and Ann at the airport. They ______ (go) to Berlin and I ______ (go) to Madrid. We ______ (have) a chat while we ______ (wait) for our flights.",
    "I ______ (cycle) home when suddenly a man ______ (step) out into the road. I ______ (go) quite fast but luckily I ______ (manage) to stop and ______ (not/ hit) him.",
    "Flight 2001 ______ (fly) from London to New York when it suddenly ______ (encounter) turbulence and ______ (drop) 15,000 feet. The plane ______ (carry) over 300 passengers.",
    "While divers ______ (work) off Florida, they ______ (discover) a shipwreck. The divers ______ (film) life on a coral reef when they ______ (find) the gold.",
    "The ambulance driver ______ (make) a phone call when the thief ______ (start up) the ambulance. He ______ (speed) away when the driver ______ (see) him and ______ (call) the police.",
    "Police ______ (stop) a motorist as she ______ (speed). While they ______ (search) the trunk, they ______ (find) three snakes. The driver said she ______ (take) them to a pet fair.",
    "Last night when we ______ (come) down the hill, we ______ (see) a strange object. We ______ (stop) the car. As we ______ (watch) it, it suddenly ______ (fly) away and ______ (disappear).",
    "I ______ (finally/ find) the right room. It ______ (already/ be) full of students. Some ______ (talk) in Spanish. I ______ (choose) a seat and ______ (sit) down. The teacher ______ (walk) in and the conversation ______ (stop).",
  ]],
  IX: ["Quá khứ đơn / hiện tại hoàn thành", "Chia động từ; AI chấm. (bài IX)", "TB", [
    "I ______ (have) this shirt for nearly four years.",
    "Joanna ______ (tidy) her desk, but now it's in a mess again.",
    "Mike ______ (lose) his key. He can't find it anywhere.",
    "The last time I ______ (go) to Brighton was in August.",
    "I ______ (finish) my homework. I ______ (do) it before tea.",
    "And the race is over! Micky Simpson ______ (win) in a record time!",
    "Martin ______ (be) to Greece five times. He loves the place.",
    "Of course I can ride a bike. But I ______ (not/ ride) one for years.",
    "I don't know Carol's husband. I ______ (never/ meet) him.",
    "Rupert ______ (leave) a message for you. He ______ (ring) last night.",
    "Your car looks very clean. ______ (you/ wash) it?",
    "We ______ (move) here in 1993. We ______ (be) here a long time now.",
    "Mr Clack ______ (work) in a bank for 15 years. Then he gave it up.",
    "Is this the first time you ______ (cook) pasta?",
    "I ______ (work) for a computer company since I ______ (graduate) from university.",
    "We ______ (post) the parcel three weeks ago. If you still ______ (not/ receive) it, please inform us.",
    "Albert Einstein ______ (be) the scientist who ______ (develop) the theory of relativity.",
    "My grandfather ______ (die) 30 years ago. I ______ (never/ meet) him.",
    "Is your father at home? — No, he ______ (go) out. — When ______ (he/ go) out? — About ten minutes ago.",
    "How long ______ (you/ live) there? — 5 years. — Where ______ (you/ live) before that?",
  ]],
  X: ["Hội thoại — quá khứ / hiện tại hoàn thành", "Chia động từ; AI chấm. Gõ nhiều đáp án cách nhau bằng ';'. (bài X)", "TB", [
    "______ (you/ hear) the news about David? — No. ______ (what/ happen)?",
    "______ (he/ have) an accident. When he was walking down some steps, ______ (he/ fall) and ______ (break) his leg.",
    "When ______ (it/ happen)? — Yesterday afternoon. Melanie ______ (tell) me about it last night.",
    "______ (you/ know) about it last night, and ______ (you/ not/ tell) me!",
    "Well, ______ (I/ not/ see) you last night. And ______ (I/ not/ see) you today, until now.",
    "______ (he/ have) lots of accidents. ______ (he/ do) the same thing about two years ago.",
  ]],
  XII: ["Hiện tại hoàn thành / quá khứ hoàn thành", "Chia động từ (có thể phủ định); AI chấm. (bài XII)", "K", [
    "Who is that woman? I ______ (never/ see) her before.",
    "The house was dirty. They ______ (clean) it for weeks.",
    "There was no sign of a taxi, although I ______ (order) one half an hour before.",
    "You can have that newspaper. I ______ (finish) with it.",
    "We went to the box office at lunch-time, but they ______ (already/ sell) all the tickets.",
    "It isn't raining now. It ______ (stop) at last.",
    "It'll soon get warm here. I ______ (turn) the heating on.",
    "It was twenty to six. Most of the shops ______ (just/ close).",
    "Karen didn't want to come because she ______ (already/ see) the film.",
    "There's no more cheese. We ______ (eat) it all.",
    "I'm pleased to see you after such a long time. We ______ (not/ see) each other for five years.",
    "I spoke to Melanie at lunch-time. Someone ______ (tell) her the news earlier.",
    "By 1960 most of Britain's old colonies ______ (become) independent.",
    "Don't you want to see this program? It ______ (start).",
    "At first I thought I ______ (do) the right thing, but I soon realised that I ______ (make) a serious mistake.",
  ]],
  XIII: ["Quá khứ đơn / quá khứ hoàn thành", "Chia động từ; AI chấm. (bài XIII)", "K", [
    "The house was very quiet when I ______ (get) home. Everybody ______ (go) to bed.",
    "The apartment was hot when I got home, so I ______ (turn) on the air conditioner.",
    "______ (you/ meet) Tom at the party? — No, he ______ (already/ go) home when I ______ (arrive).",
    "I ______ (feel) better after I ______ (take) the medicine.",
    "I was late. The teacher ______ (already/ give) a quiz when I ______ (get) to class.",
    "It was raining hard, but by the time the class ______ (be) over, the rain ______ (stop).",
    "When I saw that Mike was having trouble, I ______ (help) him. He ______ (be) very appreciative.",
    "We were driving along when we ______ (see) a car which ______ (break) down, so we ______ (stop) to help.",
    "We ______ (arrive) at work and ______ (find) that somebody ______ (break) into the office. So we ______ (call) the police.",
    "Yesterday I ______ (go) to my daughter's dance recital. I ______ (never/ be) to one before. I ______ (not/ take) lessons when I ______ (be) a child.",
  ]],
  XIV: ["HTHT tiếp diễn / QKHT tiếp diễn", "Chia động từ; AI chấm. (bài XIV)", "K", [
    "It was empty, but the television was still on. Someone ______ (watch) it.",
    "I really must go to the dentist. One of my teeth ______ (ache) for weeks.",
    "I hope the bus comes soon. I ______ (wait) for 20 minutes.",
    "He was very tired because he ______ (work) hard all day.",
    "At last the bus came. I ______ (wait) for 20 minutes.",
    "The telephone ______ (ring) for almost a minute. Why doesn't someone answer it?",
    "Ken gave up smoking two years ago. He ______ (smoke) for 30 years.",
    "We were extremely tired at the end of the journey. We ______ (travel) for more than 24 hours.",
    "I haven't finished this letter yet. — You ______ (write) since lunch-time.",
    "Our game of tennis was interrupted. We ______ (play) for about half an hour when it started to rain.",
  ]],
  XV: ["Tổng hợp thì quá khứ", "Chia động từ; AI chấm. Gõ nhiều đáp án cách nhau bằng ';'. (bài XV)", "K", [
    "A few days ago I ______ (see) a man whose face ______ (be) familiar. I couldn't think where I ______ (see) him before. Then I ______ (remember) who it ______ (be).",
    "I ______ (knock) on the door but there ______ (be) no answer. Either he ______ (go) out or he ______ (not/ want) to see anyone.",
    "Sharon ______ (go) to the station to meet Paul. When she ______ (get) there, Paul ______ (already/ wait) for her. His train ______ (arrive) early.",
    "When I got home, Bill ______ (lie) on the sofa. He ______ (not/ watch) the TV. He ______ (fall) asleep and ______ (snore). I ______ (turn) the TV off and he ______ (wake) up.",
    "Last night I ______ (just/ go) to bed and ______ (read) when suddenly I ______ (hear) a noise. I ______ (get) up but I ______ (not/ see) anything, so I ______ (go) back to bed.",
    "Mary ______ (have to) go to New York but she almost ______ (miss) the plane. She ______ (stand) in the queue when she ______ (realize) she ______ (leave) her passport at home. She ______ (get) back just in time.",
    "I ______ (meet) George and Linda as I ______ (walk) through the park. They ______ (be) to the Sports Center where they ______ (play) tennis. They ______ (invite) me but I ______ (not/ have) time.",
  ]],
  XVI: ["Hoàn thành câu hỏi", "Viết câu hỏi với động từ phù hợp; AI chấm. (bài XVI)", "TB", [
    "I'm looking for Paul. ______ him? — Yes, he was here a moment ago.",
    "Why ______ to bed so early last night? — Because I was feeling very tired.",
    "Where ______? — Just to the postbox. I want to post these letters.",
    "______ television every evening? — No, only if there's a good program.",
    "How long ______ here? — Nearly ten years.",
    "How was your holiday? ______ a nice time? — Yes, it was great.",
    "______ Julie recently? — Yes, I met her a few days ago.",
    "What ______ (she wearing)? — A red sweater and black jeans.",
    "I'm sorry to keep you waiting. ______ long? — No, only about ten minutes.",
    "How long ______ you to get to work in the morning? — Usually about 45 minutes.",
    "______ with that newspaper yet? — No, I'm still reading it.",
    "______ to the United States? — No, never, but I went to Canada a few years ago.",
  ]],
  XVII: ["Hoàn thành câu theo gợi ý", "Viết theo từ trong ngoặc, dùng thì phù hợp; AI chấm. (bài XVII)", "TB", [
    "We bought this picture a long time ago. ______ (we/ have/ it) for ages.",
    "Sandra finds her mobile phone useful. ______ (she/ use/ it) all the time.",
    "There's a new road to the motorway. ______ (they/ open/ it) yesterday.",
    "We decided not to go out because ______ (it/ rain) quite hard.",
    "Vicky doesn't know where her watch is. ______ (she/ lose/ it).",
    "We had no car at that time. ______ (we/ sell/ our old one).",
    "I bought a new jacket last week but ______ (I/ not/ wear/ it) yet.",
    "Claire is on a skiing holiday. ______ (she/ enjoy/ it), she says.",
    "The color of this paint is awful. ______ (I/ hate/ it).",
    "Henry is annoyed. ______ (he/ wait) a long time for Claire.",
    "______ (I/ check/ them) several times already.",
    "Sandra and Laura like tennis. ______ (they/ play/ it) every weekend.",
    "Sorry, I can't stop now. ______ (I/ go) to an important meeting.",
    "It's a long time since ______ (I/ last/ see/ her).",
    "I found my key when ______ (I/ look) for something else.",
    "______ (I/ read) the book you lent me but ______ (I/ not finish/ it) yet.",
    "I wasn't hungry at lunchtime because ______ (I/ have/ a big breakfast).",
    "Ann is out of breath. ______ (she/ run).",
    "Where's my bag? ______ (somebody/ take/ it).",
    "We were surprised when Jenny and Andy got married. ______ (they/ only/ know/ each other) for a few weeks.",
  ]],
  XVIII: ["Hiện tại diễn tả tương lai", "Chia động từ (hiện tại đơn/tiếp diễn cho tương lai); AI chấm. (bài XVIII)", "TB", [
    "We ______ (have) a party on Sunday. Would you like to come?",
    "What time ______ (your train/ leave) tomorrow? — It ______ (get) into Paris at eleven twenty-three.",
    "______ (the film/ begin) at 3.30 or 4.30? — It ______ (begin) at 3.30. I ______ (pick) you up at 3.",
    "I ______ (go) to an ice hockey match this evening. What time ______ (the match/ start)? — It ______ (start) at half past seven.",
    "When ______ (the art exhibition/ open)? — It ______ (open) on 3 May and ______ (finish) on 15 July.",
    "What time ______ (you/ finish) work tomorrow? — I ______ (not/ go) to work tomorrow. I ______ (stay) at home.",
    "______ (you/ do) anything tomorrow morning? — Yes, I ______ (go) to the airport to meet Richard. His plane ______ (arrive) at eight fifteen.",
    "Where ______ (you/ go) on your holiday? — We ______ (leave) for Paris next week. The train ______ (leave) early on Tuesday.",
    "When ______ (it/ finish)? — It ______ (last) till 2:30.",
    "I can't. I ______ (meet) Jennifer at the library.",
  ]],
  XIX: ["will / be going to", "Viết động từ với will hoặc be going to; AI chấm. (bài XIX)", "TB", [
    "Do you have any plans for this afternoon? — Yes, I ______ (look round) the museum.",
    "It's coming towards us. It ______ (attack) us.",
    "Can I speak to Jim, please? — Just a moment. I ______ (get) him.",
    "The weather's too nice to stay indoors. I ______ (sit) in the garden. — I think I ______ (join) you.",
    "Don't worry about the letter. I'm sure you ______ (find) it.",
    "I think aliens ______ (land) on the earth in the next ten years.",
    "Have you decided about the job? — Yes, I ______ (not/ apply) for it.",
    "Shhh! Don't make so much noise. You ______ (wake) everybody up.",
    "Have you heard about Michelle? — I heard that she ______ (get) married.",
    "I want to go out tomorrow but I haven't got a baby-sitter. — That's no problem. I ______ (look after) them.",
    "Shall we meet on Friday morning? — I can't. I ______ (go) to the dentist.",
    "I need somebody to take me to the airport. — I ______ (take) you. — OK. We ______ (leave) at about 9 then.",
  ]],
  XXI: ["Hiện tại / tương lai đơn / tương lai tiếp diễn", "Chia động từ; AI chấm. (bài XXI)", "K", [
    "I ______ (meet) you at the airport tomorrow. After you ______ (clear) customs, look for me. I ______ (stand) right by the door.",
    "When ______ (you/ leave) for Florida? — Two days from now I ______ (lie) on the beach.",
    "Please visit today when you ______ (have) a chance. I ______ (shop) from 1:00 to 2:30, but I ______ (be) home after that.",
    "Would you like to come to our party? — Thanks, but I ______ (work) all day tomorrow.",
    "I ______ (call) you this afternoon. — Don't call between 3 and 5 because I ______ (not/ be) home. I ______ (study) at the library.",
    "I ______ (attend) a seminar in Los Angeles. Ms. Gomes ______ (substitute-teach) for me. When I ______ (return), be ready for the exam.",
    "What ______ (you/ do) in five years' time? — I'm going into business when I ______ (leave) college. Five years from now I ______ (run) a big company.",
    "As soon as your ankle ______ (heal), you can play soccer. At this time next week, you ______ (play) soccer.",
    "I ______ (tell) you when I ______ (be) ready. I promise I ______ (not be) very long.",
    "Trevor and Laura ______ (not/ go) for a picnic tomorrow. They ______ (clean) the house. They always ______ (do) it on Sunday.",
  ]],
  XXII: ["Tương lai tiếp diễn / tương lai hoàn thành", "Chia động từ; AI chấm. (bài XXII)", "K", [
    "We're going to play tennis from 3 until 4.30. So at 4 o'clock ______ (we/ play) tennis.",
    "Can we meet tomorrow afternoon? — Not in the afternoon. ______ (I/ work).",
    "Will you be free at 11.30? — Yes. ______ (the meeting/ finish) by that time.",
    "If he continues like this, ______ (he/ spend) all his money before the end of his holiday.",
    "If you need to contact me, ______ (I/ stay) at the Lion Hotel until Friday.",
    "We're late. ______ (the film/ already/ start) by the time we get to the cinema.",
    "Next Monday, ______ (Chuck/ be) in Britain for exactly three years.",
    "Is it all right if I come at 8.30? — No, ______ (I/ watch) the football then. — What about 9.30? — ______ (the match/ finish) by then.",
    "By the end of the trip, ______ (she/ travel) more than 3,000 miles.",
    "______ (you/ pass) the post office on your way home? — The post office ______ (close) by the time I get home.",
  ]],
  XXIV: ["Hội thoại điền động từ (tổng hợp)", "Chia động từ; AI chấm. Gõ nhiều đáp án cách nhau bằng ';'. (bài XXIV)", "K", [
    "______ (you/ buy) anything at the antiques sale yesterday? — No, ______ (I/ want) to buy some jewellery, but ______ (I/ leave) my credit card at home.",
    "Are you still copying those addresses? — No, that's all. ______ (I/ finish) now.",
    "How long ______ (we/ wait) now? — ______ (we/ be) here since ten to five.",
    "When ______ (we/ drink) our coffee, ______ (she/ hurry) off home.",
    "______ (I/ have) breakfast when ______ (I/ hear) the news.",
    "How long ______ (you/ do) that? — Since I was sixteen. ______ (we/ do) about a dozen concerts.",
    "I'm sure ______ (she/ cry). Her eyes looked red. — Perhaps ______ (she/ have) some bad news.",
    "When ______ (we/ hear) the shot, ______ (we/ throw) ourselves to the floor.",
    "I rang but you weren't in. — No, ______ (I/ have) lunch at that time.",
    "You look tired. — ______ (I/ work) all day.",
    "Is Laura at home? — No, ______ (she/ go) out about an hour ago.",
    "______ (I/ not/ finish) this letter yet. — ______ (you/ write) it since lunchtime.",
    "You've got new neighbors. — Yes. ______ (they/ move) in last month.",
    "______ (you/ arrive) at the theatre in time? — No. By the time we got there, ______ (it/ already/ begin).",
    "______ (I/ live) in a friend's house at the moment. Luckily ______ (I/ find) a place of my own now.",
    "______ (she/ never/ use) a computer before, so ______ (she/ not/ know) what to do.",
    "Which language ______ (you/ learn)? — When ______ (the Spanish course/ start)? — ______ (it/ start) next week.",
  ]],
};

// ---------------- MCQ sections. Each item: [stem, [options], correctIndex] ----------------
const MCQ = {
  VIII: ["Chọn dạng đúng (hội thoại Andy–Jane)", "Chọn dạng đúng của động từ. (bài VIII)", "TB", [
    ["What ______ in this part of London?", ["are you doing", "do you do"], 0],
    ["Well, ______ at flats round here.", ["I'm looking", "I look"], 0],
    ["Flats? ______ to move?", ["Are you wanting", "Do you want"], 1],
    ["In fact, Adam and I ______ married.", ["are getting", "get"], 0],
    ["When ______?", ["have you decided", "did you decide"], 1],
    ["It was while we ______ with his family in Scotland.", ["were staying", "stayed"], 0],
    ["Now ______ to find a suitable flat.", ["we try", "we're trying"], 1],
    ["______ you manage to buy one soon.", ["I hope", "I'm hoping"], 0],
    ["Oh, we ______ for one to buy.", ["aren't looking", "don't look"], 0],
    ["We ______ enough money yet.", ["aren't having", "don't have"], 1],
    ["______ to find somewhere to rent.", ["We're wanting", "We want"], 1],
    ["That's what we ______ at first.", ["have been doing", "did"], 1],
    ["In the end my brother ______ us some money.", ["was lending", "lent"], 1],
    ["That's how we ______ to buy ours.", ["were managing", "managed"], 1],
    ["Perhaps I'll talk to my family before we ______ a flat.", ["choose", "have chosen"], 0],
    ["My family ______ us a lot of helpful advice.", ["gave", "were giving"], 0],
    ["I ______ for somewhere to sit down when I bumped into you.", ["looked", "was looking"], 1],
    ["I ______ into you. Let's go.", ["bumped", "have bumped"], 0],
  ]],
  XI: ["Điền lá thư — trắc nghiệm (Save Our Pub)", "Chọn đáp án đúng điền vào lá thư. (bài XI)", "K", [
    ["A few days ago I ______ that someone plans to knock down the White Horse Inn.", ["had learned", "learned", "has learned", "learn"], 1],
    ["This pub ______ the center of village life for centuries.", ["has been", "had been", "was", "is"], 0],
    ["It ______ at our crossroads for 500 years.", ["stood", "is standing", "stands", "has stood"], 3],
    ["It ______ famous in the old days.", ["has been", "is", "was", "had been"], 2],
    ["Shakespeare once ______ there, they say.", ["had stayed", "stayed", "stays", "has stayed"], 1],
    ["I ______ in Brickfield all my life.", ["lived", "am living", "was", "have lived"], 3],
    ["The villagers ______ about the plans for less than a week.", ["have known", "knew", "had known", "know"], 0],
    ["Last week we ______ happy.", ["are being", "has been", "were", "had been"], 2],
    ["But this week we ______ angry.", ["are", "were", "has been", "are being"], 0],
    ["We ______ them, you'll see.", ["are stopping", "will stop", "stop", "are going to stop"], 1],
  ]],
  XXIII: ["Chọn dạng đúng (will / present / future)", "Chọn dạng đúng của động từ. (bài XXIII)", "K", [
    ["I'd better go. ______ home, and I haven't got any lights on my bike.", ["I'm cycling", "I cycle"], 0],
    ["Oh, yes. ______ dark soon.", ["It'll be", "It'll have been"], 0],
    ["The rent is expensive. — Yes. ______, I've decided.", ["I'll move", "I'm going to move"], 1],
    ["I'd like a photo of Martin and me. — ______ one with your camera, then.", ["I'll take", "I'm going to take"], 0],
    ["Have you booked a holiday? — Yes, ______ to Spain.", ["we go", "we're going"], 1],
    ["Can I borrow your bike on Monday? — Sorry, but ______ it. I always cycle to work.", ["I'll be using", "I'll have used"], 0],
    ["Oh dear, I've spilt my coffee. — ______ a cloth.", ["I get", "I'll get"], 1],
    ["What's that man doing up there? — Oh no! ______!", ["He'll jump", "He's going to jump"], 1],
    ["It's quite a long way. — Yes. ______ about five miles by the time we get back.", ["We'll be walking", "We'll have walked"], 1],
    ["It said on the radio that ______.", ["it's snowing", "it's going to snow"], 1],
    ["By November ______ for this company for 6 years.", ["I will be working", "I will have worked"], 1],
    ["______ until Wednesday because I've got an exam.", ["I revise", "I'm revising"], 1],
    ["______ your work by 9 tonight? — No, ______ a meeting at that time.", ["Will you have finished … I'll be having", "Will you finish … I'm going to have"], 0],
    ["I'm going to a job interview this afternoon. — ______ you one of mine.", ["I'll lend", "I'm going to lend"], 0],
    ["I can't go out until ______. I haven't got a raincoat.", ["it will stop raining", "it stops raining"], 1],
  ]],
};

function levelsObj(level, n) {
  return JSON.stringify({ [level]: n });
}

function block(id, title, desc, level, type, items) {
  const out = [];
  out.push(`do $$`);
  out.push(`declare ex uuid := '${id}'; q uuid;`);
  out.push(`begin`);
  out.push(`  delete from exams where id = ex;`);
  out.push(`  insert into exams (id,title,description,total_questions,levels,created_by) values (ex,'${esc(title)}','${esc(desc)}',${items.length},'${levelsObj(level, items.length)}'::jsonb,null);`);
  items.forEach((it, i) => {
    const pos = i + 1;
    if (type === "text") {
      out.push(`  insert into questions (exam_id,position,stem,level,type,accept) values (ex,${pos},'${esc(it)}','${level}','text','[]'::jsonb);`);
    } else {
      const [stem, opts, ok] = it;
      out.push(`  insert into questions (exam_id,position,stem,level,type,accept) values (ex,${pos},'${esc(stem)}','${level}','mcq','[]'::jsonb) returning id into q;`);
      const rows = opts.map((o, idx) => `(q,'${L[idx]}','${esc(o)}',${idx === ok},${idx})`).join(",");
      out.push(`  insert into choices (question_id,label,content,is_correct,position) values ${rows};`);
    }
  });
  out.push(`end $$;`);
  return out.join("\n");
}

const parts = [
  "-- ============================================================",
  "-- 20260601000016_all_exams.sql — remaining Mai Lan Hương Tenses sections.",
  "-- text => AI-graded; mcq => with answer key. System exams (created_by null).",
  "-- ============================================================",
  "",
];

let total = 0;
for (const key of Object.keys(TEXT)) {
  const [title, desc, level, items] = TEXT[key];
  parts.push(block(uuid(ids[key]), title, desc, level, "text", items));
  parts.push("");
  total += items.length;
}
for (const key of Object.keys(MCQ)) {
  const [title, desc, level, items] = MCQ[key];
  parts.push(block(uuid(ids[key]), title, desc, level, "mcq", items));
  parts.push("");
  total += items.length;
}

fs.writeFileSync(__dirname + "/migrations/20260601000016_all_exams.sql", parts.join("\n") + "\n");
const nText = Object.keys(TEXT).length, nMcq = Object.keys(MCQ).length;
console.log(`Wrote migration: ${nText} text exams + ${nMcq} mcq exams, ${total} questions total.`);
