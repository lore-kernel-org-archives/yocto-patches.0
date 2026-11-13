Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1093.1794592959250287827
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 10:02:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google2 header.b=fJyR1toA;
 spf=pass (domain: smile.fr, ip: 209.85.221.50, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-491846221ffso1346767f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 10:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google2; t=1794592957; x=1795197757; darn=lists.yoctoproject.org;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7yb5bO4xWlnch8DIAUq15cJ4z05R20l3bRwqQgWLPUs=;
        b=fJyR1toAI48HPazkB/RjSOrt0InxGpstW/CVNDUOwyow4IQKVHFkK1mNxdJM4UduVW
         tRKoUtqndfY/qRXIcAItaI9clLiwHfGlLoVSG2yVBDq0aByMiqoftmtZpl81wuA0H2lm
         NXLkvzkakZOHGAtW5TUNBbaZpHnOvqJlFKsMsj1rtufZZ+4o56ZHmBJ3PUjXgvFHHJPv
         KoA9UTfKjseeek4rwk6omT/RXHBLk7+y0HmgKYMrWO7JTQYPPqhK7svgus4JEcxHxLxN
         zXMhZYYft+9HZYaz8wtMvitWxGZ37aEwC1Xc+cvaz4F7PzK8tF7ONox+gRYTU0X9iKQF
         1HxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794592957; x=1795197757;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7yb5bO4xWlnch8DIAUq15cJ4z05R20l3bRwqQgWLPUs=;
        b=1YigbAS870k13eeDpojxNoYpQVfFANSmXrVftu7V1UkAigTyOs/7f37VZvnSXHZb0C
         LekfOmGg1OYBUlOGQ87SSN0sUP8ivDmhinQEpbuG+pG6KQwn3wPI9NmDRCjvO1JBt1lX
         xjU6rXhITP7P7ejlHAtYlTLLN/SVxJlOdD8pkOlE1yyN/jWxQX3SxfWK8FpRW6KwM94Q
         zZCnCs/X8sQ3StdbJCP9eD27T2u8ltFgEid/WGYCefELL0HP6q5ZfFjquoTxgC9Tas8b
         s7MiwWnxfSSIrjDXfRiJeHzWa6UcppihFntvAS12jZM207vndIWbu5zpNufq4PHIEwUA
         xKiw==
X-Forwarded-Encrypted: i=1; AL+hErEwznElOfiqN5j/A4Jmww7vvkUsiHiDaLwgTReTuBd+x/8myvbvgUOjSAf6rml3uy5Hr0zA/FtcFvRTU2Pf@lists.yoctoproject.org
X-Gm-Message-State: APuU4Z+83tqs7kETCtIRREMwqOg+OcT5SnP0YGztwVhpjRRxo+S0Y5QC
	iovyxG33B+ieTG3SOZytHXomUaTip/zT/cSM8Nw6DsADjJlO0NLfl2kRzL/pvYBLS4o=
X-Gm-Gg: AYBFou0uy8bFiZ9kJa7c5PTGfw9Z/d0iil9WOCCjJUFrcwEa8aCD3+UqEVe5fZSFOqt
	l0mHN4BB7SOm4ITKQnXGMPBP+ZfEFXlvExvYzYz7JPJJh6PBf3SzJSa1VLj+89uAHsBnAdX4uve
	qf+0gcgyD1jB+VjPaZWZ/f3nnZ8zpXnUn07QjyG4EzYEoL+GQsHQSCxrIbazauAeNFgfW3GzQKa
	HlEWixp8T66pl1NxPOvotxUJHUR80nJoQa6SPmnUOpBUwbPrJuIDF/ha00gP1qT1d5aD7i5ghmc
	2bI1u1jvwWm4L8a6ZavqCWlYbalSQVZRjj9RUOM6OxTtySEoxlHkSB8yQW+5cWQ2ZzM6JVfz2aO
	o+tm2U0N3xwfVXakJ6ylrfZXLUZaB7TRXORKIrRy1XPhJqidgVd282akOYggfvQQ8WJH76ceKh6
	5W3/L/sPOaEm367fQKVIrblHs4ldPMgHfRIhA6V/2LzPXeihOTE2wfqjIzTaHJAy18Z+JuF955A
	qZ5fcIP7pzAPqQyoHc1OKTif9YigMVL21snmRIFpwV4a9M2Q/xfAJM/eVVoTIhUNZtHNzbF9+5k
	PgdTf7vdJu5aRxVPp0qUSjmH+BKYno2s0eqQIE6trn0BHEyTKooR3b5AUNvR3ZZnm6KRXCyQ2Be
	zT/4KvUjZrGchrrn4ug==
X-Received: by 2002:a05:6000:24c8:b0:49c:9e8a:31b9 with SMTP id ffacd0b85a97d-49c9e8a3318mr6829978f8f.9.1794592957306;
        Fri, 13 Nov 2026 10:02:37 -0800 (PST)
Return-Path: <yoann.congal@smile.fr>
Received: from localhost (2a01cb001331aa00d795e58479169e39.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:d795:e584:7916:9e39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f7828a4sm6685532f8f.23.2026.11.13.10.02.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 10:02:36 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Nov 2026 19:02:36 +0100
Message-Id: <DMUA3YZ5XCVE.34QEVSM08HIU2@smile.fr>
Subject: Re: [yocto-patches] [pseudo][pseudo-1.9]PATCH 00/10] Backports from
 master to 1.9 branch
From: "Yoann Congal" <yoann.congal@smile.fr>
To: "Yoann Congal" <yoann.congal@smile.fr>,
 <yocto-patches@lists.yoctoproject.org>
X-Mailer: aerc 0.20.0
References: <1794413712-18072-1-git-send-email-mark.hatle@kernel.crashing.org> <DMT7HDZT3P6O.1DHC10SI0D1UB@smile.fr>
In-Reply-To: <DMT7HDZT3P6O.1DHC10SI0D1UB@smile.fr>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 18:02:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5338

On Thu Nov 12, 2026 at 12:46 PM CET, Yoann Congal wrote:
> On Wed Nov 11, 2026 at 5:15 PM CET, Mark Hatle via yocto-patches wrote:
>> The following are backporting a small number of fixes:
>>  Add open_tree test case
>>  Fix makewrapper compilation warning
>>  Don't require linux/mount.h (part of the open_tree work)
>>  State a minimum gcc 5 requirement
>>  Add in the parallel rename/link locking
>>
>> It is also adding to new files:
>>  Add a README.security and AGENTS.md file
>>
>> Note, there is are a couple of additional pending changes likely
>> specifically for Yocto Bug 16493.  This is still in testing and
>> will be sent to the list once ready.
>>
>> Mark Hatle (10):
>>   test: Skip open_tree tests when the function or syscall is unavailable
>>   makewrappers: Don't generate unused _int paths with noignore_path
>>   ports/linux: Don't require <linux/mount.h>
>>   configure: Require GCC 5 or later
>>   pseudo_client: serialize path changes across clients
>>   ports: hold the path lock in create and metadata wrappers
>>   ports: check created files under the path lock before recording them
>>   test-parallel-ops: Add a parallel create/rename/link/chmod test
>>   README.security: Add information specific to file/process security
>>   AGENTS.md: Add to assist future developers
>
> Hello,
>
> FWIW, I plan to integrate these onto my stables branches to test them.
>
> Thanks!

This series passed a-full on scarthgap (on first try!):
https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/5116

Integration was done with this patch:
https://git.yoctoproject.org/poky-contrib/commit/?h=3Dstable/scarthgap-nut&=
id=3D7a6ca5322b313aabf826b0105eaf37a0add2f3b0

I plan to do the same for blacksail and wrynose. It might take 1-2 weeks
to get sufficient testing on all those branches.

Regards,
--=20
Yoann Congal
Smile ECS

