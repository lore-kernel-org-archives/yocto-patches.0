Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEEFFD8779
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 23:37:23 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2801.1773790635185999191
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Mar 2026 16:37:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=SbNSuDAb;
 spf=pass (domain: smile.fr, ip: 209.85.128.44, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso53361915e9.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 16:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1773790633; x=1774395433; darn=lists.yoctoproject.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYCWKdDUCkOrlGCnipjf9ZfcLpHwVJ4YnihYdTf2XQs=;
        b=SbNSuDAb/9GQTlHS09BDYSR0UZhLdtxK0RSvly64dzb2D5KujO+FvaczWkHDVYeU/5
         Jug68LXHL1t1ukAumYZqKbAB98lHWv9u9WBF9maRJRIPXbalaH344OHZ17Lfv/gF70tD
         HFYoZer7CN7cvOkgJyFOdO6a9ssyyyJZpOv30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773790633; x=1774395433;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tYCWKdDUCkOrlGCnipjf9ZfcLpHwVJ4YnihYdTf2XQs=;
        b=KX4fiXdYPQWKONSByxMc/mG6B5Eithl4ZOGXU5DI3T7IY5ppVSgW3ff2m4uE1Sp5Dm
         6anEr4SBolD82/jj5RQUPldDw/QdcqFaA0uCgbRuZLd6czmvxK7CqWgfZww5a8Xd1VSg
         eqj99ymGhVZzmn2KgfE7S8H3twSlzx7TGpj0Mvoco5qVzHHM0sPTqH7Xn2XKqb/r30xL
         Zaa/Yx2/bhrROfiuGH+RxXce5l9hDxomLFMYWDToSaqUQZAOlTrCTxwezrhhiuIgaL0G
         8lh8tGaoShpq5VXqvMh/topvhWHXqN49aVHWQN/utmmEmFUHZYr4onRrHshbGj1OyE/d
         dUtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmfZAf6816imD1ryzcY+UDMINZHdwYUP+dBR1pfw+Gdc4t7QnVbRBL0ExD3cQ8twNDeFGOxZ1S7pngh0xk@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YzgvmakccK9l2pEAeEQ+yciEr5zN+GUfCTVdmHQsTjYRzqkX75a
	jE9cZYSv3LzU7bT3D5PGgpqzU9du124+i/ebkIPS7ln04LGg1Eoh6A55kUqCg0Qvje09/3qXgYH
	509z5
X-Gm-Gg: ATEYQzyTWb+lstiTxMsXqBvfg4EqPPb6Nsw9WdOKJOKS3OfVMlNDlB5zUJVassuKbYs
	PWJsZIMLGriEtiy6L+8/610F+hZqlfWnR3V5/czA0sK9pW8EsA9H3a/H+tZ8VuBxV47aTZLcSPv
	ZEhol+mSKVBHKiqQYLczGh59l8rw3NKzI7+WWZyi4lBTDrcNtcbd9glI+uUIRndrUW8xEPF/H2O
	kO9+E07wPg5iLuPLekj4dul2kkgTcOONdOk45ACs5l6wAO9r8lgeKrDTTgCpiGJXzRLMJTluqNI
	f+tLbZsrv6X1cSSOH3fiCd1DtmPCU5cF0C5hxiyN7dJaMe00MucQOZxB/tlFS8Y5xwLROhBLehR
	p90OcF5Ls+sloaAwstmOSlkfnYJrSq5ngDgwVq7os4b8GpTQ6/lgLERaU/OqKublFPScZ4PSyvZ
	pqAyImx60yvFNJx0rjzZsh+zw7iFvIjLdDyk74tPyl9k2mamZJwOmHln0TuPfRvnG9HntpamHzo
	/KvMMePMNJqLRA=
X-Received: by 2002:a05:600c:45d5:b0:485:345b:ccb1 with SMTP id 5b1f17b1804b1-486f4579cf2mr21754675e9.27.1773790633550;
        Tue, 17 Mar 2026 16:37:13 -0700 (PDT)
Received: from localhost (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f4613243sm11461545e9.1.2026.03.17.16.37.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 16:37:12 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Mar 2026 00:37:12 +0100
Message-Id: <DH5GAV2IHRUU.A6HAQK8JRUTX@smile.fr>
Subject: Re: [yocto-autobuilder-helper][PATCH v2 5/5] dashboard/bugtriage:
 Add a "View on Bugzilla" link
From: "Yoann Congal" <yoann.congal@smile.fr>
To: "Yoann Congal" <yoann.congal@smile.fr>,
 <yocto-patches@lists.yoctoproject.org>
X-Mailer: aerc 0.20.0
References: <20260317232902.2404326-1-yoann.congal@smile.fr>
 <20260317232902.2404326-5-yoann.congal@smile.fr>
In-Reply-To: <20260317232902.2404326-5-yoann.congal@smile.fr>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 23:37:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3500

On Wed Mar 18, 2026 at 12:29 AM CET, Yoann Congal wrote:
> From: Yoann Congal <yoann.congal@smile.fr>
>
> That link may be useful to jump from bugtriage page to bugzilla (e.g. to
> then do bulk edit, ...)
>
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> ---

FYI, you can see it at
https://ycongal-smile.github.io/tmp/scripts/dashboard/bugtriage/index.html

>  scripts/dashboard/bugtriage/index.html | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/dashboard/bugtriage/index.html b/scripts/dashboard/b=
ugtriage/index.html
> index 758284d..c154c9e 100644
> --- a/scripts/dashboard/bugtriage/index.html
> +++ b/scripts/dashboard/bugtriage/index.html
> @@ -491,10 +491,11 @@
>        navLink.innerText =3D `(${bugCount})`
>      }
> =20
> -    function populateTable(selector, bugs) {
> +    function populateTable(selector, bugs, bzlink) {
>        if (bugs.length =3D=3D=3D 0) {
>          const p =3D document.createElement("p");
>          p.innerHTML =3D "<em>No bugs found</em>.";
> +        p.innerHTML +=3D " " + bzlink.outerHTML;
>          document.querySelector(selector).replaceChildren(p);
>          appendBugCount(selector, 0)
>          return;
> @@ -525,7 +526,7 @@
>        }
> =20
>        const footer =3D table.appendChild(document.createElement("tfoot")=
);
> -      footer.innerHTML =3D `<tr><td colspan=3D"${fields.size}">${bugs.le=
ngth} bug${bugs.length > 1 ? 's' : ''} found</td></tr>`;
> +      footer.innerHTML =3D `<tr><td colspan=3D"${fields.size}">${bugs.le=
ngth} bug${bugs.length > 1 ? 's' : ''} found. ${bzlink.outerHTML}</td></tr>=
`;
> =20
>        appendBugCount(selector, bugs.length)
> =20
> @@ -546,6 +547,11 @@
>        params.append("o0", "notregexp",)
>        params.append("v0", `^(${ignoreProducts.map((s) =3D> escapeRegExp(=
s)).join("|")})$`)
> =20
> +      var bzlink =3D document.createElement("a");
> +      var buglistURL =3D `${serverUrl}/buglist.cgi?${params}`;
> +      bzlink.setAttribute("href", buglistURL);
> +      bzlink.appendChild(document.createTextNode("View on Bugzilla"));
> +
>        try {
>          const response =3D await fetch(`${serverUrl}/rest/bug?${params}`=
);
>          if (!response.ok) {
> @@ -553,7 +559,7 @@
>          }
> =20
>          const data =3D await response.json();
> -        populateTable(selector, data.bugs);
> +        populateTable(selector, data.bugs, bzlink);
>        } catch (error) {
>          console.error(`Failed to fetch bugs for ${selector}: ${error}`);
>          alert("Error fetching bugs. Check the console for details.");


--=20
Yoann Congal
Smile ECS


