Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AE8CD5BCF
	for <webhook@archiver.kernel.org>; Mon, 25 May 2026 08:53:58 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12161.1779699236901297465
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 25 May 2026 01:53:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PatodZ72;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-44a14580111so7066913f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 25 May 2026 01:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1779699235; x=1780304035; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8DM2+6A9fIqnigZrkQvK8HWkkfYFHn8Jgd4l4jI7C8s=;
        b=PatodZ72q4D3MNCSFYy1BYW4fdUEOl4hzX9wSpaEl9bbrbPWn0FR/UjhK0QMyLDWI7
         pNHls+eRHaxySpknM5up7/hUNq2ciNM4HUoliw8WY8ZlHz6SgiAPFu/ct7XUZWDiYxcB
         /DCiLCFvw7OP9SS6Qy3xzp/vgDQYWnBUtzLy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779699235; x=1780304035;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8DM2+6A9fIqnigZrkQvK8HWkkfYFHn8Jgd4l4jI7C8s=;
        b=K5FvVnF+G0RsCRm2jcW3/w1cyDKEmtk383mV/e3StrRaJ4oYDheANr5b11FKiBN+cw
         MQCAe35k4iCkHRM/W9b/gGOwdI2i1l7n4U3PejFTAxpssmeK5AbtDeFjkSPO6YGvQKRE
         L5PPOzNav5rzuAB3UaVbqpVVKpvNTDJ9dSwi08qmstqzmfo669O6qvA7chO2DY8LN1nN
         mQZCqJRXdDTOAjw78Z/sq5wscnjQH4KJXa79gfxzywF8nB0ajvF78wzn6CM9JCyBYLfT
         ah3rArx+ma37kvuetqezFu/t183zj3B+F6P1uP8DekfNgFhWTK9e6qfXkWIOLsiTs1UC
         VjMw==
X-Gm-Message-State: AOJu0Yw5EcTw3Leuw24eYoR5F1GBbQ9Ds+TLDgYef/gyvk7/+86uYOGt
	/SIzduhak/DPkegAW1pOclvyixDYcYgd4bQxpZpodvmAjTEbsglVA+ae/xJXx5Jg6z5ziDSFAM+
	cwi/m
X-Gm-Gg: Acq92OEBCNcwUl0b3dnZkXommT9Z5zeDlwFfivp7lSzx9xUsZeHKO5fkIkfBOEos/M2
	rysYWFSCkx21QcdKYLOTXZFRe4yGHc+AUimTVSCkbkuwC8ewoNUWRSkiVOP9DazpVmy9470t7NH
	W+HQAkVgS594AIfhdOnHwSIRaDywLBCk5mzqLp/Ri5i/zac9WCSeDnhZO5JOPd8eC0ZCL3XbEq9
	H2bsemQhlOA5mmIVOuTomKYGvnvSdyQMcE1u3L7IRhZBZyB9nsmrJ8PhYSFES37Idbp6fwVu4vd
	wowC+gzWcq7aOoLGbkp9v9kNSaQ1i1D55evgsVf6/RRUYH/5KhrH6XF0wcB7PP25U6KYs6cDQim
	SqBbHejLD5JnTrRKloVK1A9Rzi7f1DppBXuvfwczWxU06MknsKiXMiv/gnrY4k9pgxkKOW34Wy3
	GBT3EQkEojpiQzCpV5mKG4aC0wNePlkc8KanpOHbSMD0HwKDHUfgXvucdaLdwBuxi/7ARnHD/Tq
	3qeUhzKRIinuwaB0IOPoLNd
X-Received: by 2002:a05:6000:1446:b0:43d:7a97:78af with SMTP id ffacd0b85a97d-45eb38e04e3mr23560307f8f.42.1779699235106;
        Mon, 25 May 2026 01:53:55 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:4698:2a3:881f:e81b? ([2001:8b0:aba:5f3c:4698:2a3:881f:e81b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d71688sm27104274f8f.33.2026.05.25.01.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 01:53:54 -0700 (PDT)
Message-ID: <10353a01dd5b874831051216ed82e0a2569ac2df.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [AUH] [PATCH 1/2] git: use temp file for commit
 message to avoid shell escaping issues
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org, daniel.turull@ericsson.com
Cc: alex.kanavin@gmail.com, Qi.Chen@windriver.com
Date: Mon, 25 May 2026 09:53:52 +0100
In-Reply-To: <20260525080418.942183-1-daniel.turull@ericsson.com>
References: <20260525080418.942183-1-daniel.turull@ericsson.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 25 May 2026 08:53:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4038

T24gTW9uLCAyMDI2LTA1LTI1IGF0IDEwOjA0ICswMjAwLCBEYW5pZWwgVHVydWxsIHZpYSBsaXN0
cy55b2N0b3Byb2plY3Qub3JnIHdyb3RlOgo+IEZyb206IERhbmllbCBUdXJ1bGwgPGRhbmllbC50
dXJ1bGxAZXJpY3Nzb24uY29tPgo+IAo+IFBhc3NpbmcgdGhlIGNvbW1pdCBtZXNzYWdlIHZpYSAt
bSAiLi4uIiBpbnRlcnBvbGF0ZXMgaXQgZGlyZWN0bHkgaW50bwo+IGEgc2hlbGwgY29tbWFuZCwg
Y2F1c2luZyBhIHN5bnRheCBlcnJvciB3aGVuIHRoZSBtZXNzYWdlIGNvbnRhaW5zIHNwZWNpYWwK
PiBjaGFyYWN0ZXJzIHN1Y2ggYXMgYmFja3RpY2tzLCBkb3VibGUgcXVvdGVzLCBvciBzaGVsbCBt
ZXRhY2hhcmFjdGVycy4KPiAKPiBVc2UgYSB0ZW1wb3JhcnkgZmlsZSB3aXRoIC1GIGluc3RlYWQs
IHdoaWNoIGJ5cGFzc2VzIHNoZWxsIGludGVycHJldGF0aW9uCj4gZW50aXJlbHkuCj4gCj4gQUkt
R2VuZXJhdGVkOiBraXJvIHdpdGggY2xhdWRlLW9wdXMtNC42IG1vZGVsCj4gU2lnbmVkLW9mZi1i
eTogRGFuaWVsIFR1cnVsbCA8ZGFuaWVsLnR1cnVsbEBlcmljc3Nvbi5jb20+Cj4gLS0tCj4gwqBt
b2R1bGVzL3V0aWxzL2dpdC5weSB8IDE1ICsrKysrKysrKysrLS0tLQo+IMKgMSBmaWxlIGNoYW5n
ZWQsIDExIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL21v
ZHVsZXMvdXRpbHMvZ2l0LnB5IGIvbW9kdWxlcy91dGlscy9naXQucHkKPiBpbmRleCBiMzgzMDQ5
Li5iNzMyY2RiIDEwMDY0NAo+IC0tLSBhL21vZHVsZXMvdXRpbHMvZ2l0LnB5Cj4gKysrIGIvbW9k
dWxlcy91dGlscy9naXQucHkKPiBAQCAtNTQsMTAgKzU0LDE3IEBAIGNsYXNzIEdpdChvYmplY3Qp
Ogo+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHNlbGYuX2NtZCgiYWRkICIgKyBzcmMpCj4gwqAK
PiDCoMKgwqDCoCBkZWYgY29tbWl0KHNlbGYsIGNvbW1pdF9tZXNzYWdlLCBhdXRob3I9Tm9uZSk6
Cj4gLcKgwqDCoMKgwqDCoMKgIGlmIGF1dGhvciBpcyBOb25lOgo+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHJldHVybiBzZWxmLl9jbWQoImNvbW1pdCAtYSAtcyAtbSBcIiIgKyBjb21taXRfbWVz
c2FnZSArICJcIiIpCj4gLcKgwqDCoMKgwqDCoMKgIGVsc2U6Cj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIHNlbGYuX2NtZCgiY29tbWl0IC1hIC0tYXV0aG9yPVwiIiArIGF1dGhvciAr
ICJcIiAtbSBcIiIgKyBjb21taXRfbWVzc2FnZSArICJcIiIpCj4gK8KgwqDCoMKgwqDCoMKgIGlt
cG9ydCB0ZW1wZmlsZQo+ICvCoMKgwqDCoMKgwqDCoCB3aXRoIHRlbXBmaWxlLk5hbWVkVGVtcG9y
YXJ5RmlsZShtb2RlPSd3Jywgc3VmZml4PScudHh0JywgZGVsZXRlPUZhbHNlKSBhcyBmOgo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGYud3JpdGUoY29tbWl0X21lc3NhZ2UpCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgdG1wID0gZi5uYW1lCj4gK8KgwqDCoMKgwqDCoMKgIHRyeToKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpZiBhdXRob3IgaXMgTm9uZToKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHJldHVybiBzZWxmLl9jbWQoImNvbW1pdCAtYSAtcyAtRiAiICsgdG1w
KQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVsc2U6Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCByZXR1cm4gc2VsZi5fY21kKCJjb21taXQgLWEgLS1hdXRob3I9XCIiICsgYXV0
aG9yICsgIlwiIC1GICIgKyB0bXApCj4gK8KgwqDCoMKgwqDCoMKgIGZpbmFsbHk6Cj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgb3MudW5saW5rKHRtcCkKPiAKCgpXaHkgZGVsZXRlPUZhbHNlIGFu
ZCB0aGVuIHRoZSB0cnkvZmluYWxseT8KCkNoZWVycywKClJpY2hhcmQK


