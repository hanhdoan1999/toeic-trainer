/* Generates a sample import CSV (demo_part5.csv) from the demo exam.
   Run: node supabase/_gen_demo_csv.js */
const fs = require("fs");

// [stem, A, B, C, D] for each question, in PDF order.
const Q = [
  ["The manager decided ______ the meeting.", "to cancel", "canceled", "canceling", "cancel"],
  ["Please avoid ______ during the presentation.", "talked", "to talk", "talking", "talk"],
  ["All employees must ______ the safety rules.", "follow", "following", "followed", "to follow"],
  ["I would like ______ a table for two.", "reserve", "reserved", "to reserve", "reserving"],
  ["Thank you for ______ the report on time.", "to submit", "submitted", "submitting", "submit"],
  ["They agreed ______ the proposal.", "to approve", "approving", "approved", "approve"],
  ["He finished ______ the report.", "wrote", "write", "to write", "writing"],
  ["The boss made the team ______ late.", "staying", "stayed", "to stay", "stay"],
  ["You should ______ the instructions first.", "reads", "reading", "read", "to read"],
  ["She refused ______ the document.", "sign", "to sign", "signing", "signed"],
  ["They are interested in ______ for our company.", "to work", "worked", "work", "working"],
  ["Would you mind ______ the window?", "to open", "open", "opening", "opened"],
  ["Would you like ______ something to drink?", "have", "having", "had", "to have"],
  ["Visitors may ______ the museum for free.", "entered", "to enter", "enter", "entering"],
  ["We planned ______ a new branch.", "open", "opening", "opened", "to open"],
  ["The company postponed ______ the event.", "hold", "holding", "to hold", "held"],
  ["Let me ______ you with your bags.", "helped", "helping", "help", "to help"],
  ["He left the office without ______ anyone.", "telling", "to tell", "told", "tell"],
  ["______ a foreign language takes time.", "Learned", "Learn", "Learning", "Learns"],
  ["She managed ______ the problem alone.", "solved", "to solve", "solve", "solving"],
  ["We must carefully ______ the contract.", "to review", "reviewing", "reviewed", "review"],
  ["I will have the technician ______ the printer.", "fix", "fixing", "fixed", "to fix"],
  ["I heard the director ______ at the meeting.", "spoken", "to speak", "spoke", "speak"],
  ["It is important ______ the deadline.", "met", "to meet", "meet", "meeting"],
  ["The board considered ______ the policy.", "to change", "changing", "changed", "change"],
  ["The plan failed ______ enough revenue.", "to generate", "generate", "generating", "generated"],
  ["Before ______ the contract, read all terms.", "sign", "signing", "signed", "to sign"],
  ["He arrived early in order ______ the room.", "prepared", "preparing", "to prepare", "prepare"],
  ["I will have the report ______ by noon.", "finished", "to finish", "finishing", "finish"],
  ["This software helps users ______ time.", "save", "saving", "saves", "saved"],
  ["The client would like ______ the terms before signing.", "discuss", "to discuss", "discussed", "discussing"],
  ["They had to delay ______ the new model.", "to launch", "launched", "launch", "launching"],
  ["Staff should regularly ______ their passwords.", "to update", "update", "updating", "updated"],
  ["We watched the engineers ______ the machine.", "installs", "install", "installed", "to install"],
  ["Both sides agreed ______ the negotiation.", "continue", "continuing", "to continue", "continued"],
  ["She is responsible for ______ the accounts.", "to manage", "managed", "managing", "manage"],
  ["The fee includes ______ all materials.", "provide", "provided", "to provide", "providing"],
  ["It is easy ______ this device.", "operated", "operate", "operating", "to operate"],
  ["The supervisor made everyone ______ overtime.", "worked", "work", "working", "to work"],
  ["Management decided ______ the office.", "relocating", "relocated", "relocate", "to relocate"],
  ["He is good at ______ problems quickly.", "solved", "to solve", "solve", "solving"],
  ["The manual helps customers ______ the product correctly.", "assembling", "to assemble", "assembled", "assembles"],
  ["To stay safe, avoid ______ the machine while it runs.", "touched", "touching", "to touch", "touch"],
  ["The shipment might ______ tomorrow.", "arrived", "to arrive", "arriving", "arrive"],
  ["We upgraded the system so as ______ errors.", "reduced", "reduce", "to reduce", "reducing"],
  ["The supplier refused ______ the prices.", "lower", "lowering", "lowered", "to lower"],
  ["I saw smoke ______ from the building.", "come", "coming", "came", "to come"],
  ["Once you finish ______ the form, submit it.", "complete", "completed", "to complete", "completing"],
  ["______ feedback from clients improves service.", "Collected", "Collecting", "Collects", "Collect"],
  ["The policy lets employees ______ from home.", "worked", "work", "to work", "working"],
  ["The team must immediately ______ the issue.", "to address", "addressing", "address", "addressed"],
  ["We had the equipment ______ before the inspection.", "checked", "checking", "check", "to check"],
  ["The trainer watched each new hire ______ the procedure correctly.", "to perform", "performed", "performs", "perform"],
  ["The manager insisted on ______ every invoice.", "reviewed", "reviewing", "review", "to review"],
  ["Despite delays, they managed somehow ______ the target.", "reaching", "reached", "reach", "to reach"],
  ["The committee decided to postpone ______ a final vote.", "to take", "take", "taken", "taking"],
  ["The new rules made staff ______ ID badges daily.", "to wear", "worn", "wear", "wearing"],
  ["From my desk I could hear the printer ______ all morning.", "running", "ran", "to run", "run"],
  ["All drivers should always ______ their seatbelts.", "fastening", "fasten", "to fasten", "fastened"],
  ["It is essential for managers ______ clear instructions.", "to give", "give", "giving", "gave"],
  ["Regular maintenance helps the machines ______ longer.", "lasted", "last", "lasting", "lasts"],
  ["The firm plans ______ overseas next year.", "expanding", "to expand", "expanded", "expand"],
  ["Employees can avoid ______ fines by following the rules.", "paying", "pay", "paid", "to pay"],
  ["She had her secretary ______ the visitors in.", "show", "shown", "showing", "to show"],
  ["They had the broken window ______ the next day.", "replace", "replacing", "replaced", "to replace"],
  ["Witnesses saw the truck ______ the barrier.", "hitted", "hits", "to hit", "hit"],
  ["They cut costs by ______ energy use.", "reducing", "to reduce", "reduce", "reduced"],
  ["Candidates must clearly ______ their qualifications.", "state", "to state", "stated", "stating"],
  ["______ the new software will take several weeks.", "Installed", "Installing", "To installing", "Install"],
  ["In order ______ delays, submit forms early.", "avoiding", "to avoid", "avoid", "avoided"],
  ["The union refused ______ the new schedule.", "accept", "to accept", "accepting", "accepted"],
  ["The CEO is considering ______ a subsidiary abroad.", "to open", "open", "opening", "opened"],
  ["The brochure helps tourists ______ the city easily.", "navigated", "navigating", "navigates", "to navigate"],
  ["The supervisor wouldn't let the trainees ______ the equipment unsupervised.", "use", "to use", "used", "using"],
  ["I heard the alarm ______ for several minutes.", "rung", "ringing", "rang", "to ring"],
  ["Workers should never ______ safety procedures.", "ignored", "ignoring", "ignore", "to ignore"],
  ["The device failed ______ properly after the update.", "to function", "function", "functioned", "functioning"],
  ["Would you mind ______ me the file?", "sending", "to send", "sent", "send"],
  ["The report is about ______ customer satisfaction.", "improved", "improve", "to improve", "improving"],
  ["The delay made customers ______ angry.", "feeling", "feel", "felt", "to feel"],
  ["It was difficult ______ everyone during the holidays.", "contacted", "contact", "to contact", "contacting"],
  ["The visitors watched the artisan ______ a vase by hand.", "made", "makes", "to make", "make"],
  ["After negotiation, both parties agreed ______ the dispute.", "to settle", "settled", "settling", "settle"],
  ["Bad weather delayed ______ the cargo.", "shipped", "ship", "shipping", "to ship"],
  ["The system can automatically ______ backups every night.", "to create", "created", "creating", "create"],
  ["The hotel had the rooms ______ before guests arrived.", "cleaned", "to clean", "clean", "cleaning"],
  ["Clear signage helps drivers ______ the right exit.", "finding", "finds", "found", "find"],
  ["He completed the task without ______ any help.", "request", "requested", "requesting", "to request"],
  ["Label the boxes so as ______ confusion.", "prevented", "preventing", "to prevent", "prevent"],
  ["The board decided ______ the merger.", "to approve", "approve", "approving", "approved"],
  ["The renovation will include ______ the lobby.", "redesigning", "to redesign", "redesigned", "redesign"],
  ["Applicants must accurately ______ all fields.", "to complete", "completing", "completed", "complete"],
  ["We could feel the building ______ during the earthquake.", "shook", "to shake", "shaken", "shaking"],
  ["The new policy lets customers ______ items within 30 days.", "return", "returned", "to return", "returning"],
  ["It is necessary ______ all data regularly.", "back up", "backed up", "backing up", "to back up"],
  ["The department plans ______ two new positions.", "to create", "created", "create", "creating"],
  ["The driver swerved to avoid ______ the pedestrian.", "hits", "to hit", "hit", "hitting"],
  ["The client had his lawyer ______ the agreement.", "review", "reviewing", "reviewed", "to review"],
  ["The supervisor heard the alarm ______ once and rushed out.", "sound", "to sound", "sounding", "sounded"],
  ["To pass inspection, the factory must strictly ______ all regulations.", "to follow", "following", "follow", "followed"],
];

// Answer key from the PDF (BẢNG ĐÁP ÁN), one row of 10 per line (câu 1–100).
const ANSWERS = [
  "A C A C C A D D C B", // 1-10
  "D C D C D B C A C B", // 11-20
  "D A D B B A B C A A", // 21-30
  "B D B B C C D D B D", // 31-40
  "D B B D C D B D B B", // 41-50
  "C A D B D D C A B A", // 51-60
  "B B A A C D A A B B", // 61-70
  "B C D A B C A A D B", // 71-80
  "C D A C D A D C C A", // 81-90
  "A D D A D A D A A C", // 91-100
].join(" ").split(/\s+/);

function level(pos) {
  if (pos <= 20) return "D";
  if (pos <= 50) return "TB";
  return "K";
}

// CSV field quoting: wrap in quotes if it contains comma/quote/newline; escape " as "".
function field(v) {
  const s = String(v);
  if (/[",\n\r]/.test(s)) return '"' + s.replace(/"/g, '""') + '"';
  return s;
}

const lines = ["position,level,stem,A,B,C,D,answer"];
Q.forEach((row, i) => {
  const pos = i + 1;
  const [stem, a, b, c, d] = row;
  const ans = ANSWERS[i];
  lines.push([pos, level(pos), field(stem), field(a), field(b), field(c), field(d), ans].join(","));
});

if (Q.length !== ANSWERS.length) {
  throw new Error(`Mismatch: ${Q.length} questions vs ${ANSWERS.length} answers`);
}

fs.writeFileSync(__dirname + "/demo_part5.csv", lines.join("\n") + "\n");
console.log("Wrote demo_part5.csv with", Q.length, "questions.");
