Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8775.1792580627138209983
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 21 Oct 2026 04:03:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=AWwSkmO3;
 spf=pass (domain: gmail.com, ip: 209.85.219.52, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-9178aabd30dso5750326d6.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 21 Oct 2026 04:03:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792580626; cv=none;
        d=google.com; s=arc-20260327;
        b=W+nJezT5guoViJkKjT3P0urqSo4YQMNkyS44lgdFgBG3jVhSCedI5dqpwRcW6Qng4w
         +pDab6GyVnxeecmz1fUq8l7zw7YNmWUoxLMwkCt9xtWpdVCKBl5SBOF2THGVrDngSwIY
         J63ZjwBhtPFFBfOTdG40KUKxenLEEI/eHpm3pjclm+xpdorI/xF5bBPEhVHfzd+hSfWI
         Sh5t26wg0LpikuiItrLv3SmBB/zm8bCJqeB9hDxfDh/KpFBQqLBxpqBjDdKnLAMhrRy+
         XAM7g5CTnZZdmHNFBfh70G4dDs89iN01Ucbxg+Cl4vqKplPSewHBOGBrgXsVSKuMN1dF
         WFbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BSJbYq7PhW76O3WdHHOU74tB2EVc5FyprWX50AzOZP0=;
        fh=WFk6WqVLMumhhBiMgmEG6lAyoeJm2sRryqhUz7/ms2k=;
        b=BfMPMTcgVRKgU5woo/Xkvc/JPdDNreDRg175+rwjZ+w0ikqiX9w3PiU78zXUH1IMxN
         VM2RVu8HLDNnaNPfYrdOaieo0ZKkKyYSJtLuXKnRTkfLb5c3YbPKvQcp2DWPaagg7G0T
         ULZFU36By0McLnBuLcv4NpVAwYoHm4mRtwdkenRontD4ec+bpKeqQDtVGXBoU416SaMk
         Jzlr3dQEX7Ol9yynAOkxUk8JZ9GHiGH3euNTaCMb21PNQ1FE8g0wiDor+YYqZdUOlSZ8
         QSA+Cr58OKA2l/e5e6GkqjGxm6fPPzMtOu/EjKI3G7akMbww9Kgu9xWBYosv2ev7P+LY
         sKzA==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792580626; x=1793185426; darn=lists.yoctoproject.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BSJbYq7PhW76O3WdHHOU74tB2EVc5FyprWX50AzOZP0=;
        b=AWwSkmO3pBJFXZtZ+dCUjp7XPLXUJBI03Bi3/LXwxxZrKPPTGwbP+arL9czQofw+Lw
         6YQFgcsllzQveuy6KzIWNFzzXIBwJbIFl/nhEL+O/4MEudSXv8r/3JZKcWNCegf9aTgb
         d1rv0fXVarJaEpSzZh0PkjdeYukx+xk2yu3xdcQNf2v2Ei70jbmk36U8pUvrMasiR6qA
         +4Oz6XRm7XQrmwacrOsOxBR4iqAO3HUBetfPKqkwAPtxjtoSBjlj27B+1S5Al5w8RGoB
         vUYXzpeIlT+WFIHJC7HSCRg9C0eNSv4VhYGIyfuzexFJGfO4Rcg/Hjjt1rf60HB45cix
         QCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792580626; x=1793185426;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BSJbYq7PhW76O3WdHHOU74tB2EVc5FyprWX50AzOZP0=;
        b=JmaDDsu0t1kHfRxfG1m/9SCoh5tNi8C7eyOOcZE7DrsjrqOX5X90JKmJucLO88HqoG
         3NfK/r22P/4ojv5gclJB00xOgplnniyPBDOCUj5YN/Ef/OdViswPo+fhjUPEomaUmoFx
         EihQFdJ7H8vj2E3Mgh6WOKfpGtvo/VewPOHali879jlk8bSNqUGPpAzruG2dLOo2RTA6
         r+VunNipOuRoGCi6IlFz8Jr0aTWoyYj7CnUsmBS2cz6xu1Uq3MjV0kEcpvlHb/QWKT4T
         5qG20hnykrR2J7MuvqsG8XBcaBl1AKXgOutKy+G6e4+YPdrAz64NY/MKLpkTyrI+cBNF
         j8WA==
X-Gm-Message-State: AFq9FYJ1skFJxsj1jFNU4k6JmzH0GymIT8PVWAOaEsMjdKxKD11ype2W
	VofAL7mqwo2Jon1qNtKj6IbJoqdTEURvsW0a3EDjgdNjt40J0SytmrLwlkA+OQmSS6s+wEYyRKJ
	VzC64xGKpY0aClfVvQv1rWbw8fWukYTU=
X-Gm-Gg: AYBFou1LhIRO2GDlpVw7MXuUBoPmKaMTGR7hFa/Xg1vok2ixTiF0gF7F3AegnigiLLB
	OVwNFnxlm06tEfE3LPkyUToFsZE1SZ5wfKulj2kChV2nicRjkR7x2w0O3Vu0dZFBId/MipCSeCF
	asM45YRGgKBT+1KB+AUUti+XYeV25yIq9Sq9BxZl88cYC9CC6zDcO7NeiRCDcFZ1TketL6IGCiy
	lx928QT9DHMocfN9pCsUIZ9wHf/SSC9HrFt5c4/1/BLPLMl0S4BPKqj01KgAIqJdT2yU+O9pJNC
	e5ZAH+HwTP3O27s9VOtjK70OWhvE34P5vr1h4ItWYK56L+mePHfnckWw+jr5SnEF/vszWGDQfvw
	mnp+7gW4mcNgFigc1T7AKnnEielf1Yq5coKudp2WMyDjdcFnSEuwK3/MYtF7enq+SNW0Rs8g=
X-Received: by 2002:a05:6214:2026:b0:91b:ca97:9c4 with SMTP id
 6a1803df08f44-91c12f55fe1mr27251726d6.47.1792580625883; Wed, 21 Oct 2026
 04:03:45 -0700 (PDT)
MIME-Version: 1.0
References: <20261020090917.3132154-1-daniel.turull@ericsson.com>
 <CANNYZj9P-15TVaO5fb3AD9Xa1mrMpt9aP7GApTDGombuGNe6oA@mail.gmail.com> <f3a03e28b28b60530cc801b66001a3c9e6b11543.camel@ericsson.com>
In-Reply-To: <f3a03e28b28b60530cc801b66001a3c9e6b11543.camel@ericsson.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 21 Oct 2026 13:03:34 +0200
X-Gm-Features: AclHuK-rg9Ora7q_92pQ5aH8qG2ztEX87CAgVb55Za2ePjMcC3pemVGJrAszwP8
Message-ID: <CANNYZj8n_Xy2jNwttzuaLRg0Hbh70mTFbSQddhXpNA71aTeo5Q@mail.gmail.com>
Subject: Re: [yocto-autobuilder-helper][PATCH] auh-config: skip changelog in
 commit message for noisy recipes
To: Daniel Turull <daniel.turull@ericsson.com>
Cc: "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="0000000000006fe5e6065e57b356"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 21 Oct 2026 11:03:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5122

--0000000000006fe5e6065e57b356
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Oct 2026 at 12:48, Daniel Turull <daniel.turull@ericsson.com>
wrote:

> Ok, I wanted to avoid extra logic and keep it simpler. How one detects
> programmatically badly formed changelogs? but I see your point.
>
> I just followed the same way was as blacklist is done. It is also manually
> maintained.
>

Blacklist hasn't changed in years (we should rename it by the way to
something that does not have 'black' in it), and is superseded by
RECIPE_NO_UPDATE_REASON variable in recipes. This list is likely to be more
fluid.

I think a better approach is to put a hint variable for devtool directly
into recipes, as this is a devtool upgrade setting really, not an AUH
setting. Devtool would indicate to AUH via json that the changelog it
produced is likely 'badly formed', and then AUH can handle that further.
Then recipe maintainers can handle appropriate settings directly through
recipe patches to oe-core.

Alex

--0000000000006fe5e6065e57b356
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Wed, 21 Oct 2026 at 12:48, Daniel Turu=
ll &lt;<a href=3D"mailto:daniel.turull@ericsson.com">daniel.turull@ericsson=
.com</a>&gt; wrote:</div><div class=3D"gmail_quote gmail_quote_container"><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Ok, I wanted to avoid extr=
a logic and keep it simpler. How one detects<br>
programmatically badly formed changelogs? but I see your point.=C2=A0<br>
<br>
I just followed the same way was as blacklist is done. It is also manually<=
br>
maintained.=C2=A0<br></blockquote><div><br></div><div>Blacklist hasn&#39;t =
changed in years (we should rename it by the way to something that does not=
 have &#39;black&#39; in it), and is superseded by RECIPE_NO_UPDATE_REASON =
variable in recipes. This list is likely to be more fluid.</div><div><br></=
div><div>I think a better approach is to put a hint variable for devtool di=
rectly into recipes, as this is a devtool upgrade setting really, not an AU=
H setting. Devtool would indicate to AUH via json that the changelog it pro=
duced is likely &#39;badly formed&#39;, and then AUH can handle that furthe=
r. Then recipe maintainers can handle appropriate settings directly through=
 recipe patches to oe-core.</div><div><br></div><div>Alex</div></div></div>

--0000000000006fe5e6065e57b356--
