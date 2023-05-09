import
    std/[httpclient, strutils, os, rdstdin, uri, random]

var
    DOMAINS: seq[string] = @[
        "mymassive.yachts","stonks.boats","stonks.fun","toes.beauty","barefoot.pics","shareit.pics",
        "gamer.tattoo","shipment.website","imagevault.cloud","sugma.mom","yum.mom","plz.life",
        "massive.mom","massive.boats","mymassive.store","mymassive.top","gamer.hair","photovault.pics",
        "bathtub.pics","foot.wiki","thisdomainislong.lol","gamergirl.pro","picshost.pics","pichost.pics",
        "imghost.pics","imagehost.pics","toldyouso.lol","toldyouso.pics","screenshare.pics","myprivate.pics",
        "noodshare.pics","cheapcinema.club","dateing.club","shrekis.life","headshot.monster","progaming.monster",
        "yourmy.monster","screenshot.best","gamingfun.me","catsnthing.com","catsnthings.fun","joinmy.site",
        "fortnitechat.site","fortnight.space","stopify.co"
    ]
    INSULTS: seq[string] = @[]

proc Grabify(link: string): void =
    try:
        let
            insult = INSULTS.sample()
            client = newHttpClient(
                headers = newHttpHeaders({
                    "user-agent": insult
                })
            )
        if client.request(link, HttpGet).status == $Http200:
            echo "[Success] Request sent with insult [ " & insult & " ]"
    except Exception:
        discard

when isMainModule:
    discard execShellCmd(when defined(windows): "cls" else: "clear")
    if not fileExists(getCurrentDir() / "insults.txt"):
        echo "No insults.txt found. Creating one..."
        writeFile(getCurrentDir() / "insults.txt", "retard")
    for insult in readFile(getCurrentDir() / "insults.txt").splitLines():
        INSULTS.add(insult)

    var grabify = readLineFromStdin("Enter a grabify URL: ").toLowerAscii()
    if not DOMAINS.contains(parseUri(grabify).hostname):
        echo "[Error] This domain is not a valid grabify domain"

    while true:
        Grabify(grabify)