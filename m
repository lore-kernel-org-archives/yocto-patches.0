Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962A3C44515
	for <webhook@archiver.kernel.org>; Thu, 16 Jul 2026 16:56:03 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17856.1784220957222526323
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Jul 2026 09:55:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=L2AY/b1x;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so15005825e9.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Jul 2026 09:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1784220955; x=1784825755; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=71xa2wSl+FKPeB85jOxSBjVU9gFwxMMOo9UJiB7Jvuk=;
        b=L2AY/b1xzLHYA8123q20CcccTH4o1Jw5LVu57CW44K/bVG/VqwY4aptr2d+oPnC+q6
         S/0fblIlUPnQzrrrxFuo9yf8A/hSG2IqZ0c3t/4mBH1XjRidiXqWQk2j7tGaHl+nScZa
         z0AF7m51jr/n/2IrXwv1Bw8FJHnYsCn8BCpLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784220955; x=1784825755;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=71xa2wSl+FKPeB85jOxSBjVU9gFwxMMOo9UJiB7Jvuk=;
        b=JttdeMUn6ycQcnGBmAtWbKhQxYRO+SUdUCOOOC3Ai562tke/xsZ2n+XL7Mfz1GK2Dz
         Qdhlau1S87TOSYEMg9zIEPKgFvyiJiI3z/uJg2kNb1lLyTlg8u44y2t8Be5IPRmBhWPx
         JYrE+pkuIB0GxptZSOmcSnzJwhet3Em+knekWajIWJSvbNVkrDESU08K4Ad0ch7XMAFO
         U3jS/e/FCiI1oABWdTqxdk7MaYmgmsQ5iU8B7veu6nMQOqTE9XAO2ErV2K+hoiGzqEwD
         VBpAhVii6z1UYUtieWAPTK0aSKpuF2+6HHm1WX+ZC5BtrDDiMv0XJ4bdGsptbw4UdIbZ
         ij3w==
X-Gm-Message-State: AOJu0Yy+7B55XNmFvK7zbNKYSXeGVpg1QMNPDNLRVZmPLFg0fQFk5vVP
	skVz70buhsQKfFUhT8l06hVPdKWQmq5sMq9DTK/sPZQL9yiCSWtyj029TbZG9mPZIUs=
X-Gm-Gg: AfdE7cnfsUZmoUzncNnB/7fBh6/obvxpPvO1nWg+E1Mdy+s2rHy3MpeN3h4DwKrFB9s
	FZysQUfZH0F8T8UvpoSVhtPEos6hnR3D5dcDvrGbtbmvYsipOYymZzoSr2dafUEHj9DmNU9x9tq
	zZ39yQru/tZZa7+joTYF6hesKXr9hrRp+Cz0OAGWAfzwf8BixrkUpaaNAYWg6avahzNuk4Cx4cD
	uYRSp+ptGA4PIpLnapO3qbcAUl4SqsV+Cz/9fLlD0z91XO8c1hViYdCSonUj7cPE792q+8CfHg8
	a0zfftUZTRSUyawojvlUE8Vhpyh4B7lxOcpO5+EFbeYRwkAnc4mjomQZUsw+oYmj9rbcIZhQ6hg
	PLDiIggBZrr8q4gd1b2YLP55w6G7KwcJmpdILvPv0yqlgHynfSJTI5mQ3dnDcFyPXnFHcwHOcB3
	C9JCY1OWj0WrXMt7TgJ7GhnHmkiFbkU1H3c3MjuRMqTD7+BMOiDFd2zfsiUusaY/bPNeM=
X-Received: by 2002:a05:600c:524a:b0:493:e97c:216e with SMTP id 5b1f17b1804b1-495483c863amr1068015e9.39.1784220955219;
        Thu, 16 Jul 2026 09:55:55 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:a03c:6417:d88d:c21a? ([2001:8b0:aba:5f3c:a03c:6417:d88d:c21a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e8c41asm71784015e9.9.2026.07.16.09.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:55:54 -0700 (PDT)
Message-ID: <4321836d169d2ff0e80884717ec1de4aaa868d83.camel@linuxfoundation.org>
Subject: Re: [pseudo] [PATCH v2 0/2] close_range: implement it rather than
 return ENOSYS
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Babanpreet Singh <bbnpreetsingh@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org, Paul Barker <paul@pbarker.dev>, 
 Mark Hatle <mark.hatle@amd.com>, Randy MacLeod
 <randy.macleod@windriver.com>, Vincent Haupert	 <mail@vincent-haupert.de>,
 Mark Hatle <mark.hatle@kernel.crashing.org>
Date: Thu, 16 Jul 2026 17:55:53 +0100
In-Reply-To: <CAO8wpHypNwFNKPCnwzcgGcMVqHK9DscZ1XO8U1GD29W1kU-NbQ@mail.gmail.com>
References: <20260715054142.7-1-bbnpreetsingh@gmail.com>
	 <20260716055633.7-1-bbnpreetsingh@gmail.com>
	 <b6bfa88be0a54a3edf8e55571d4be4e1d54e736e.camel@linuxfoundation.org>
	 <CAO8wpHypNwFNKPCnwzcgGcMVqHK9DscZ1XO8U1GD29W1kU-NbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Jul 2026 16:56:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4497

On Thu, 2026-07-16 at 08:46 -0700, Babanpreet Singh wrote:
> Thanks!
>=20
> > =C2=A0 That said, I couldn't see what pseudo_prefix_dir_fd actually hel=
ps with
> > and I couldn't see why we need that...
>=20
> I flagged it since it is held open and a close_range() sweep will wipe it=
 out. I hadn't checked if anything still reads it untill now. It seems like=
 it is just kept open and alive and the socket connection=C2=A0+ fchdir() h=
as been moved to pseudo_localstate_dir_fd.
>=20
> So, for the follow-up I'd purpose:
>=20
> 1/2: remove=C2=A0 pseudo_prefix_dir_fd
> 2/2: add pseudo_pwd_lck_fd and pseudo_util_evlog_fd to the descriptors OP=
_CLOSEFROM and OP_CLOSE_RANGE step around
>=20
> If you'd rather keep the fd, I'll drop the removal and add it to the prot=
ected set in 2/2 instead.

I'd suggest making the series the other way around, protect it for now,
send a removal patch on top and we can look at the removal patch and
test and check it isn't really used anywhere. It is possible I'm
missing some usage of it and I'm curious what Mark thinks.

The protection patch makes sense and should be easy to merge compared
to that.

Cheers,

Richard

