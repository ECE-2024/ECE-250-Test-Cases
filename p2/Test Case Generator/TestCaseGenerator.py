from random import *
import os
import shutil
import subprocess

NUM_START = 1
TEST_CASES = 300
LENGTH = 2000

TEST_DIR = "testcases"

words = ['a', 'aa', 'aaa', 'aaaa', 'aaaaaa','aaaaaaaaa', 'aaaaaaaaaaa', 'ability', 'able', 'about', 'above', 'accept', 'according', 'account', 'across', 'act', 'action', 'activity', 'actually', 'add', 'address', 'administration', 'admit', 'adult', 'affect', 'after', 'again', 'against', 'age', 'agency', 'agent', 'ago', 'agree', 'agreement', 'ahead', 'air', 'all', 'allow', 'almost', 'alone', 'along', 'already', 'also', 'although', 'always', 'American', 'among', 'amount', 'analysis', 'and', 'animal', 'another', 'answer', 'any', 'anyone', 'anything', 'appear', 'apply', 'approach', 'area', 'argue', 'arm', 'around', 'arrive', 'art', 'article', 'artist', 'as', 'ask', 'assume', 'at', 'attack', 'attention', 'attorney', 'audience', 'author', 'authority', 'available', 'avoid', 'away', 'baby', 'back', 'bad', 'bag', 'ball', 'bank', 'bar', 'base', 'be', 'beat', 'beautiful', 'because', 'become', 'bed', 'before', 'begin', 'behavior', 'behind', 'believe', 'benefit', 'best', 'better', 'between', 'beyond', 'big', 'bill', 'billion', 'bit', 'black', 'blood', 'blue', 'board', 'body', 'book', 'born', 'both', 'box', 'boy', 'break', 'bring', 'brother', 'budget', 'build', 'building', 'business', 'but', 'buy', 'by', 'call', 'camera', 'campaign', 'can', 'cancer', 'candidate', 'capital', 'car', 'card', 'care', 'career', 'carry', 'case', 'catch', 'cause', 'cell', 'center', 'central', 'century', 'certain', 'certainly', 'chair', 'challenge', 'chance', 'change', 'character', 'charge', 'check', 'child', 'choice', 'choose', 'church', 'citizen', 'city', 'civil', 'claim', 'class', 'clear', 'clearly', 'close', 'coach', 'cold', 'collection', 'college', 'color', 'come', 'commercial', 'common', 'community', 'company', 'compare', 'computer', 'concern', 'condition', 'conference', 'Congress', 'consider', 'consumer', 'contain', 'continue', 'control', 'cost', 'could', 'country', 'couple', 'course', 'court', 'cover', 'create', 'crime', 'cultural', 'culture', 'cup', 'current', 'customer', 'cut', 'dark', 'data', 'daughter', 'day', 'dead', 'deal', 'death', 'debate', 'decade', 'decide', 'decision', 'deep', 'defense', 'degree', 'Democrat', 'democratic', 'describe', 'design', 'despite', 'detail', 'determine', 'develop', 'development', 'die', 'difference', 'different', 'difficult', 'dinner', 'direction', 'director', 'discover', 'discuss', 'discussion', 'disease', 'do', 'doctor', 'dog', 'door', 'down', 'draw', 'dream', 'drive', 'drop', 'drug', 'during', 'each', 'early', 'east', 'easy', 'eat', 'economic', 'economy', 'edge', 'education', 'effect', 'effort', 'eight', 'either', 'election', 'else', 'employee', 'end', 'energy', 'enjoy', 'enough', 'enter', 'entire', 'environment', 'environmental', 'especially', 'establish', 'even', 'evening', 'event', 'ever', 'every', 'everybody', 'everyone', 'everything', 'evidence', 'exactly', 'example', 'executive', 'exist', 'expect', 'experience', 'expert', 'explain', 'eye', 'face', 'fact', 'factor', 'fail', 'fall', 'family', 'far', 'fast', 'father', 'fear', 'federal', 'feel', 'feeling', 'few', 'field', 'fight', 'figure', 'fill', 'film', 'final', 'finally', 'financial', 'find', 'fine', 'finger', 'finish', 'fire', 'firm', 'first', 'fish', 'five', 'floor', 'fly', 'focus', 'follow', 'food', 'foot', 'for', 'force', 'foreign', 'forget', 'form', 'former', 'forward', 'four', 'free', 'friend', 'from', 'front', 'full', 'fund', 'future', 'game', 'garden', 'gas', 'general', 'generation', 'get', 'girl', 'give', 'glass', 'go', 'goal', 'good', 'government', 'great', 'green', 'ground', 'group', 'grow', 'growth', 'guess', 'gun', 'guy', 'hair', 'half', 'hand', 'hang', 'happen', 'happy', 'hard', 'have', 'he', 'head', 'health', 'hear', 'heart', 'heat', 'heavy', 'help', 'her', 'here', 'herself', 'high', 'him', 'himself', 'his', 'history', 'hit', 'hold', 'home', 'hope', 'hospital', 'hot', 'hotel', 'hour', 'house', 'how', 'however', 'huge', 'human', 'hundred', 'husband', 'I', 'idea', 'identify', 'if', 'image', 'imagine', 'impact', 'important', 'improve', 'in', 'include', 'including', 'increase', 'indeed', 'indicate', 'individual', 'industry', 'information', 'inside', 'instead', 'institution', 'interest', 'interesting', 'international', 'interview', 'into', 'investment', 'involve', 'issue', 'it', 'item', 'its', 'itself', 'job', 'join', 'just', 'keep', 'key', 'kid', 'kill', 'kind', 'kitchen', 'know', 'knowledge', 'land', 'language', 'large', 'last', 'late', 'later', 'laugh', 'law', 'lawyer', 'lay', 'lead', 'leader', 'learn', 'least', 'leave', 'left', 'leg', 'legal', 'less', 'let', 'letter', 'level', 'lie', 'life', 'light', 'like', 'likely', 'line', 'list', 'listen', 'little', 'live', 'local', 'long', 'look', 'lose', 'loss', 'lot', 'love', 'low', 'machine', 'magazine', 'main', 'maintain', 'major', 'majority', 'make', 'man', 'manage', 'management', 'manager', 'many', 'market', 'marriage', 'material', 'matter', 'may', 'maybe', 'me', 'mean', 'measure', 'media', 'medical', 'meet', 'meeting', 'member', 'memory', 'mention', 'message', 'method', 'middle', 'might', 'military', 'million', 'mind', 'minute', 'miss', 'mission', 'model', 'modern', 'moment', 'money', 'month', 'more', 'morning', 'most', 'mother', 'mouth', 'move', 'movement', 'movie', 'Mr', 'Mrs', 'much', 'music', 'must', 'my', 'myself', 'name', 'nation', 'national', 'natural', 'nature', 'near', 'nearly', 'necessary', 'need', 'network', 'never', 'new', 'news', 'newspaper', 'next', 'nice', 'night', 'no', 'none', 'nor', 'north', 'not', 'note', 'nothing', 'notice', 'now', "nt", 'number', 'occur', 'of', 'off', 'offer', 'office', 'officer', 'official', 'often', 'oh', 'oil', 'ok', 'old', 'on', 'once', 'one', 'only', 'onto', 'open', 'operation', 'opportunity', 'option', 'or', 'order', 'organization', 'other', 'others', 'our', 'out', 'outside', 'over', 'own', 'owner', 'page', 'pain', 'painting', 'paper', 'parent', 'part', 'participant', 'particular', 'particularly', 'partner', 'party', 'pass', 'past', 'patient', 'pattern', 'pay', 'peace', 'people', 'per', 'perform', 'performance', 'perhaps', 'period', 'person', 'personal', 'phone', 'physical', 'pick', 'picture', 'piece', 'place', 'plan', 'plant', 'play', 'player', 'PM', 'point', 'police', 'policy', 'political', 'politics', 'poor', 'popular', 'population', 'position', 'positive', 'possible', 'power', 'practice', 'prepare', 'present', 'president', 'pressure', 'pretty', 'prevent', 'price', 'private', 'probably', 'problem', 'process', 'produce', 'product', 'production', 'professional', 'professor', 'program', 'project', 'property', 'protect', 'prove', 'provide', 'public', 'pull', 'purpose', 'push', 'put', 'quality', 'question', 'quickly', 'quite', 'race', 'radio', 'raise', 'range', 'rate', 'rather', 'reach', 'read', 'ready', 'real', 'reality', 'realize', 'really', 'reason', 'receive', 'recent', 'recently', 'recognize', 'record', 'red', 'reduce', 'reflect', 'region', 'relate', 'relationship', 'religious', 'remain', 'remember', 'remove', 'report', 'represent', 'Republican', 'require', 'research', 'resource', 'respond', 'response', 'responsibility', 'rest', 'result', 'return', 'reveal', 'rich', 'right', 'rise', 'risk', 'road', 'rock', 'role', 'room', 'rule', 'run', 'safe', 'same', 'save', 'say', 'scene', 'school', 'science', 'scientist', 'score', 'sea', 'season', 'seat', 'second', 'section', 'security', 'see', 'seek', 'seem', 'sell', 'send', 'senior', 'sense', 'series', 'serious', 'serve', 'service', 'set', 'seven', 'several', 'sex', 'sexual', 'shake', 'share', 'she', 'shoot', 'short', 'shot', 'should', 'shoulder', 'show', 'side', 'sign', 'significant', 'similar', 'simple', 'simply', 'since', 'sing', 'single', 'sister', 'sit', 'site', 'situation', 'six', 'size', 'skill', 'skin', 'small', 'smile', 'so', 'social', 'society', 'soldier', 'some', 'somebody', 'someone', 'something', 'sometimes', 'son', 'song', 'soon', 'sort', 'sound', 'source', 'south', 'southern', 'space', 'speak', 'special', 'specific', 'speech', 'spend', 'sport', 'spring', 'staff', 'stage', 'stand', 'standard', 'star', 'start', 'state', 'statement', 'station', 'stay', 'step', 'still', 'stock', 'stop', 'store', 'story', 'strategy', 'street', 'strong', 'structure', 'student', 'study', 'stuff', 'style', 'subject', 'success', 'successful', 'such', 'suddenly', 'suffer', 'suggest', 'summer', 'support', 'sure', 'surface', 'system', 'table', 'take', 'talk', 'task', 'tax', 'teach', 'teacher', 'team', 'technology', 'television', 'tell', 'ten', 'tend', 'term', 'test', 'than', 'thank', 'that', 'the', 'their', 'them', 'themselves', 'then', 'theory', 'there', 'these', 'they', 'thing', 'think', 'third', 'this', 'those', 'though', 'thought', 'thousand', 'threat', 'three', 'through', 'throughout', 'throw', 'thus', 'time', 'to', 'today', 'together', 'tonight', 'too', 'top', 'total', 'tough', 'toward', 'town', 'trade', 'traditional', 'training', 'travel', 'treat', 'treatment', 'tree', 'trial', 'trip', 'trouble', 'true', 'truth', 'try', 'turn', 'TV', 'two', 'type', 'under', 'understand', 'unit', 'until', 'up', 'upon', 'us', 'use', 'usually', 'value', 'various', 'very', 'victim', 'view', 'violence', 'visit', 'voice', 'vote', 'wait', 'walk', 'wall', 'want', 'war', 'watch', 'water', 'way', 'we', 'weapon', 'wear', 'week', 'weight', 'well', 'west', 'western', 'what', 'whatever', 'when', 'where', 'whether', 'which', 'while', 'white', 'who', 'whole', 'whom', 'whose', 'why', 'wide', 'wife', 'will', 'win', 'wind', 'window', 'wish', 'with', 'within', 'without', 'woman', 'wonder', 'word', 'work', 'worker', 'world', 'worry', 'would', 'write', 'writer', 'wrong', 'yard', 'yeah', 'year', 'yes', 'yet', 'you', 'young', 'your', 'yourself']
words = [x.lower() for x in words]
illegal = list(" ;:\'\",<.>/?[{]}\\|-_=+)(*&^%$#@!`~)}]ABCDEFGHIJKLMNOPQRSTUVWXYZ")
alpha = list("abcdefghijklmnopqrstuvwxyz")


def illegal_gen():
    a = choice(words)
    if len(a) != 1:
        wd = list(a[:randint(0, len(a)-1)])
    else:
        wd = list(a)
    wd.append(choice(illegal))

    for i in range(randint(1, 100)):
        wd.append(choice(choice([alpha, illegal])))
    shuffle(wd)
    return "".join(wd)


if os.path.exists(TEST_DIR):
    print("file/folder with name " + TEST_DIR + " detected. Please remove")
    raise SystemExit

os.mkdir(TEST_DIR)

print("Test dir made")
print("Preparing Test Cases")

for i in range(NUM_START, NUM_START+TEST_CASES):
    inp = open(TEST_DIR + "/test" + str(i) + ".in", "w")
    out = open(TEST_DIR + "/test" + str(i) + ".out", "w")
    debug = open(TEST_DIR + "/test" + str(i) + ".debug", "w")

    current_words = set()

    for l in range(LENGTH):
        cmd = randint(0, 10)

        if cmd in [0, 1, 2, 3]:
            if randint(0, 2) <= 1:
                k = randint(0, 2)
                if k <= 1 or len(current_words) == 0:
                    w = choice(words)
                else:
                    w = choice(list(current_words))

                if w in current_words:
                    out.write("failure\n")
                    debug.write("failure #i {0}\n".format(w))
                else:
                    out.write("success\n")
                    debug.write("success #i {0}\n".format(w))
                    current_words.add(w)

            else:
                w = illegal_gen()
                out.write("illegal argument\n")
                debug.write("illegal argument #i {0}\n".format(w))

            inp.write("i {0}\n".format(w))

        elif cmd in [4, 5]:
            if randint(0, 2) <= 1:
                k = randint(0, 2)
                if k == 0 or len(current_words) == 0:
                    w = choice(words)
                elif k == 1:
                    w = choice(list(current_words))
                else:
                    w = choice(list(current_words))
                    if len(w) != 1:
                        w = w[:randint(1, len(w)-1)]

                if w in current_words:
                    out.write("success\n")
                    debug.write("success #e {0}\n".format(w))
                    current_words.remove(w)
                else:
                    debug.write("failure #e {0}\n".format(w))
                    out.write("failure\n")

            else:
                w = illegal_gen()
                debug.write("illegal argument #e {0}\n".format(w))
                out.write("illegal argument\n")

            inp.write("e {0}\n".format(w))

        elif cmd in [6, 7]:
            if randint(0, 2) <= 1:
                w = choice(words)

                if w in current_words:
                    out.write("found " + w + "\n")
                    debug.write("found {0} #s {0}\n".format(w))
                else:
                    debug.write("not found #s {0}\n".format(w))
                    out.write("not found\n")

            else:
                w = illegal_gen()
                out.write("illegal argument\n")
                debug.write("illegal argument #s {0}\n".format(w))

            inp.write("s {0}\n".format(w))

        elif cmd in [8, 9]:
            if (randint(0, 1) == 0 or len(set(words) - current_words) == 0) and len(current_words) != 0:
                w = choice(list(current_words))
                if len(w) != 1:
                    w = w[:randint(1, len(w)-1)]

                inp.write("autocomplete {0}*\n".format(w))

            else:
                w = choice(list(set(words) - current_words))
                if len(w) != 1:
                    w = w[:randint(1, len(w)-1)]

                for _ in range(randint(0, 10)):
                    w += choice(alpha)

                inp.write("autocomplete {0}*\n".format(w))

            found_words = []

            for j in current_words:
                if len(j) >= len(w) and j[:len(w)] == w:
                    found_words.append(j)

            if len(found_words) != 0:
                debug.write("{0} #autocomplete {1}*\n".format(" ".join(sorted(found_words)), w))
                out.write(" ".join(sorted(found_words))+"\n")

        elif cmd in [10]:
            inp.write("clear\n")
            current_words = set()
            out.write("success\n")
            debug.write("success #clear\n")

        inp.write("size\n")
        out.write("number of words is {0}\n".format(len(current_words)))
        debug.write("number of words is {0} #size\n".format(len(current_words)))

        inp.write("empty\n")
        out.write("empty {0}\n".format(1 if len(current_words) == 0 else 0))
        debug.write("empty {0} #empty\n".format(1 if len(current_words) == 0 else 0))

        inp.write("print\n")
        if len(current_words) != 0:
            out.write(" ".join(sorted(current_words))+"\n")
            debug.write("{0} #print\n".format(" ".join(sorted(current_words))))

    inp.write("exit\n")
    inp.close()
    out.close()
    debug.close()

    print("Running test case " + str(i))
    output = subprocess.check_output(
        "./triedriver < {0}/{1} > {0}/{2}".format(TEST_DIR, "test" + str(i) + ".in", str(i) + ".o"),
        stderr=subprocess.STDOUT, timeout=10, shell=True)

    p = subprocess.run(
        "diff {0}/{1} {0}/{2}".format(TEST_DIR, "test" + str(i) + ".out", str(i) + ".o"),
        stderr=subprocess.PIPE, stdout=subprocess.PIPE, timeout=10, shell=True, check=False)

    if p.returncode == 0:
        print("success")

    else:
        print("failed")
        with open(TEST_DIR + "/" + "test" + str(i) + ".failed", "wb") as f:
            f.write(p.stdout)
            f.close()

        print("wrote differences to {0}/{1}".format(TEST_DIR, "test"+str(i)+".failed"))

