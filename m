Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38070C98302
	for <webhook@archiver.kernel.org>; Tue, 22 Sep 2026 17:40:55 +0000 (UTC)
Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1762.1790098853569474216
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 22 Sep 2026 10:40:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=owjzqy9c;
 spf=pass (domain: gmail.com, ip: 74.125.226.204, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e97e2c7b3so62281241.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 22 Sep 2026 10:40:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790098852; cv=none;
        d=google.com; s=arc-20260327;
        b=oRAhLzODBEk1rLjQ4ecUB5H0PRw4kZFRrmohSnT1SwOSh/kmlxtmKY9whsyj2rKjQi
         tghXxEqhwqYOmEzZmIr+zF/eSiRByGvBbUyf0muvwQomG5zjAghuL6g8LdQDyfrxn3N5
         AhO32EeS7VFQeQ/9qlbfyY43Mf21kuPIY79DUsEcT6HiRWbZQSWrLtYGnXcB44Awvp6l
         4TpFuykKSC2BYjYc93PscaTW0bYuBNtcpApZpplq7roPRH0vfN7uTVoseSMs3h64KSZW
         Dxr8PTuTPviPJHqB8bSz7DcD+g4INn97Fx3TjevFoxASCmgAPUc79HcY+yoT8IJ5mEaH
         wfpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Z44PXtsZ7Ke9fZDDx6NS/j9S1fy95RD6yGu/hE82/zg=;
        fh=28JQhdK5h5mLF5DLv2fLR8YFHEF0yTvH5opUNnJ6Zzo=;
        b=ZAfju4XSU9NyhnQ+qhIoCoa7kPi9piKjiibJpqU/ZYtZb0LR7rBvfP4PKK3Qenpb3S
         7Tk968E+H2Qe9tAXno2tY55H8N/FEJC8hTkIyNuc0tDZWqKmLmQyY7aTHsjtmCmDMmTf
         qSvAAQQPuiV6ayflx/zHthPEPEQWCgbuFs5A7l8WUzVk/ZNCiY6PeWEAyA5RbyetXsZc
         al+D+vjMtLVq+UES8T7buM+UtU0TVgI8yOyTNhTGnSEPbQo0jrcq4YvYuyXhfW5yL0GY
         aowdDkeFNH7GaeNp08LPcdOik8fJmdROqyJSllUSxGuJoJOfjzKiT1pzlQM0urVBRbnL
         bS9g==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790098852; x=1790703652; darn=lists.yoctoproject.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z44PXtsZ7Ke9fZDDx6NS/j9S1fy95RD6yGu/hE82/zg=;
        b=owjzqy9cDXo0phA+2E8dfcYDK5Bp98898/X1JQnTkVjI6VRjTE/tvcsQ5abJgD/T4I
         47mnxsprzMAqUXLmsA2iXaSy5G/YJIfPKw1iO4XeIZb0djPBKn1X3hK3AoqQUl2bSVym
         kg5jQAbXn/b3ozeqp2t50gIUruEXzSR7w/cHS8/uRAERCyLQ2oIG0TJc6jRWfD/dXsIB
         /CnZqIEES//Nah7OHCL6zW4nu6S9dqMmRlxqlGEL6jbrFLrn8A/krIDelmplWPA0lWBB
         aduw7AbqLJouuZT80apqHQMU8++Qu3CB0Is1CM/YUDZwvDdLTYN9bmcAKW+DRTwDjfLW
         n+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790098852; x=1790703652;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z44PXtsZ7Ke9fZDDx6NS/j9S1fy95RD6yGu/hE82/zg=;
        b=s8DnYbEfQdaxwuyNBMBgd8M9DpOZ5zRtScLojndhUse3/zHul7uYJVtd8pX/Yzm7cV
         GeLRYhH2sqU4NAyvgrHbsss9SzXT/uV1SKVdEr5S/xvnfJKZ9ZV1IXVZ4JdekNeZuxof
         16h0u3cFB1Ak/zvF6eqA+eOqkaQV3Y9EGTLLosk8bFJ6duqP0N67QwKHHDy7wJSgxGrn
         9wmM3wACKd7oItuQnD5MjIUE2umypl01ltlWlVSoCtkJBvTrytD5mXRW47qRgs+rj+Ht
         6Q8FcyOOljs6b/mnSPnLnh5AVBgQW3zxjWiMuhwucbb2KQwTdOJ1yXgK/Edk6EIgw4di
         haEQ==
X-Gm-Message-State: AFuF++mD+X6NU09wZU6OJ6XuBSLUQZsxVVPZXBYw+bOrkU4qNxztaS4E
	tgrKMT3wvLRqnIYtQC5ETMeKFb6+qvFJfe1QASsCYsOCl3yVfNhbMr5fYoRHNnVi93plCZsLdO/
	tsd2eY8BnEE6/AeGF7oAVEd4IHNTZtyUhig==
X-Gm-Gg: AYBFou01JfPi0d8pMRiYFKJDH1jU/RDQTCfKK3JjqHiCmu1+iuLD4u7M2YNGSUS8xq2
	aH3VQQMOqqkXIH58GaqM+RVAJzu9ZQ6Ob1vxbyAXikP60AOojQaGZHh/U+4YJ/7MmiXXYfQwj71
	OEmkZuOCInjoyByY/ZrI6kG2oTV69pI/hjmIwDNtdzEiF+hxt66iDzaIPNcR+FJeotAA+IU/Kku
	aYuYnh1Lh1etsCDuxHq2q9X50aPIfkcOlgrqgVlHfoVolgtKCyf/IBaIvbxhU0fNCLYWxXDv/NS
	mKq9Utr8YIBHBvdf6D+ft4Hc4iRCGUek2A6VDbVaJPjIJmXZApXlL3X26HtCUSNXCNH7zGn7tCD
	aiQPr6W6rNH9DqA==
X-Received: by 2002:a05:6102:f85:b0:7a7:ad9f:53b4 with SMTP id
 ada2fe7eead31-7ac1a8b49b7mr81568137.7.1790098852493; Tue, 22 Sep 2026
 10:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260918120342.772566-1-daniel.turull@ericsson.com>
In-Reply-To: <20260918120342.772566-1-daniel.turull@ericsson.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 22 Sep 2026 19:40:41 +0200
X-Gm-Features: AcwNN1X_Nn886QvntanWOto8gExhXTMsxCRbELOU3h4ita2WvgNZ6ExqCcCQAYY
Message-ID: <CANNYZj9MtajjcxcR-h6_NdzRgm8Bpv01-Pn7kHan52ps5fy9pA@mail.gmail.com>
Subject: Re: [auh][PATCH 1/4] steps: deduplicate same version in subject
To: daniel.turull@ericsson.com
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000374086065c15deb6"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 22 Sep 2026 17:40:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4932

--000000000000374086065c15deb6
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Sept 2026 at 14:04, <daniel.turull@ericsson.com> wrote:

>
> When multiple components are updated at the same time, we should have
> one version if it is the same. Before the patch we had
> duplicated version information in the subject.
>
> Example:
> Before: mesa-tools-native,mesa: upgrade 26.2.1 -> 26.2.2,26.2.1 -> 26.2.2
> After: mesa-tools-native,mesa: upgrade 26.2.1 -> 26.2.2
>

 This, 3/4 and 4/4 have been applied and pushed, thanks!

Alex

--000000000000374086065c15deb6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Fri, 18 Sept 2026 at 14:04, &lt;<a hre=
f=3D"mailto:daniel.turull@ericsson.com" target=3D"_blank">daniel.turull@eri=
csson.com</a>&gt; wrote:</div><div dir=3D"ltr"><div class=3D"gmail_quote"><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex"><br>
When multiple components are updated at the same time, we should have<br>
one version if it is the same. Before the patch we had<br>
duplicated version information in the subject.<br>
<br>
Example:<br>
Before: mesa-tools-native,mesa: upgrade 26.2.1 -&gt; 26.2.2,26.2.1 -&gt; 26=
.2.2<br>
After: mesa-tools-native,mesa: upgrade 26.2.1 -&gt; 26.2.2<br></blockquote>=
<div><br></div><div>=C2=A0This, 3/4 and 4/4 have been applied and pushed, t=
hanks!</div><div><br></div><div>Alex</div></div></div>
</div>

--000000000000374086065c15deb6--

