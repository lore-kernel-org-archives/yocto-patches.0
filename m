Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.367.1795708309586865962
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Nov 2026 07:51:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=PlGoEnfO;
 spf=pass (domain: konsulko.com, ip: 209.85.210.48, mailfrom: scott.murray@konsulko.com)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-85ac281604dso3553625a34.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Nov 2026 07:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795708309; x=1796313109; darn=lists.yoctoproject.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jKlupaIRRT/gWtmO4z4XPO7VP8xilUbAdfFuxNwYaqI=;
        b=PlGoEnfOjOzaER+agncgHjVAkRzqcFtewG26qwz9wVCgwpTZjsRzffHix58OIEJOy6
         WbeXQgvpsAgzhKnX4OEgBERaOMxSwpPndSGScQdkTaCveRyURLDbErDRnMmfHLExg9Gi
         tqoWGnlIPtww2GIXYBO45TN8v9anmjemR/U3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795708309; x=1796313109;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jKlupaIRRT/gWtmO4z4XPO7VP8xilUbAdfFuxNwYaqI=;
        b=TbF0o3984cE3K3YmOEI+WD+/dA7tV4lttC+GxgLvTIkOHDz/R4oldFohxtrf91SKS0
         QDOUZeLGOP7GTFN6979SVvuiN2whsjhJiG9UPdbEz3SZiGzkdRW4MTgZCbB9cnnBSbzL
         cvqfGxgm+0Q6iU0aqOwhdeY0oBksS07qp/ejBr/CCsrVmxLOkaJDZZMITa2R1qRY40Hk
         9xxvisNe3D/hPs+586LlpJTBMJSFdKFBxYVkKzjiqGBm3L16ptAdWanEsrx5+SvqK7El
         2YLmksOk5gl9A3YFaGSLbZHCfJzK7Djby6/EcDB+d5u/Oy9CnxjgPSwvr1ZUSmQG3qeR
         bvoQ==
X-Gm-Message-State: APuU4Z+IPOlWUDWl00Ie+aS2iWqUP7MdHvt4xMLk71d4CrB/4N+gmtRB
	yo02ebgpGJzjj18XHN7ZkIq8ihrHRTCeJp5UUQA9hS0duux4KJ6jI6i1oscOQGviL4U=
X-Gm-Gg: AZFdTZfOOwVVrTwKtp2j9AH/MfJpYOGdY180cZnxm8XHdiLsY5LXmNLSTwp6ULMb+jQ
	WFg8t6jqVoa1GLWh/8mk7L3uVAuzrR24atffk7WHKMT1WRk2hTF7rWDbAE6VtTgex2eKTJGuqQ1
	dYlA6uFwsRWK0UrNKwPz/6L7myM+JZWo6X4IOt0BHM/yz6/7Vy9LYw3cgaVXYR8Q1QzGJfi1iYo
	3UIkYFbj7hwLX9l/Ti+UFhIl3u55/qv/TN6FES+LCU35v6+EP8XSc0w5rHB3uU57eJMFI0+MEN6
	MUfwtu313gSuHkAvrcpudm4AdMcvgY8M3s2uGKd4yg5ZAYp3ON1YgpyxOdvwAEoRY8AncJacsen
	Xqb97FUCZy7bRPINR9ev5KiBjs9FVclRyAHK2+UOj8yVvWHFs6Ox8uRGnhW6rOjWBkRmpsQquM/
	r84Mkt7Kvu7waAxFaTCcaAw+8J9vSMLwjybG8kk/3CUIhH2jcaqE7qdZD9bQy4dtf9pOBrEG4Ac
	APKeZ4fOW/wsY5J2ys2GAow0KEdW0CLbHRNO1uQI5tkS9H9gzbBPHP0VMiAuORcXE7vufu8fsCq
	Gq7wKVLO++aDe+9FMjCFy43F1IGPtHrtZW6cX6mcs7h0Wa4zIloaJ5d5iP7N6HzSVJ63L1WAEGK
	Rj2pBdh/5dgIVdq1g07KdQha+2s4paON4SE3CwyH4gY1SL6HxuuYvM5L9
X-Received: by 2002:a05:6830:3e03:b0:7fa:ac4f:793 with SMTP id 46e09a7af769-86315a869d0mr22667888a34.31.1795708308557;
        Thu, 26 Nov 2026 07:51:48 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8631690f53dsm14059326a34.19.2026.11.26.07.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 07:51:48 -0800 (PST)
Date: Thu, 26 Nov 2026 10:51:46 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: patrick.vogelaar.dev@mailbox.org
cc: "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
Subject: Re: [meta-lts-mixins][scarthgap/rust] build problem with suricata
In-Reply-To: <1501876072.182298.1795700833777@app.mailbox.org>
Message-ID: <8f58f04f-8e29-8a96-feda-f6d46767db42@konsulko.com>
References: <917882156.181166.1795700007162@app.mailbox.org> <1501876072.182298.1795700833777@app.mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Nov 2026 15:51:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5545

On Thu, 26 Nov 2026, patrick.vogelaar.dev@mailbox.org wrote:

>
> Hi all,
>
> Commit 4c195f6dd000231e5c7797cf0d9202b6339f861d "classes/cargo: merge oe_cargo_build into cargo_do_compile" [0] causes the suricata build to fail because suricata on scarthgap uses oe_cargo_build [1] which was removed by this commit.
>
> I would be happy to do the change but I am not sure what the process is within meta-lts-mixins. Would it be a revert then of this commit or something else?
>
> [0] https://git.openembedded.org/openembedded-core/commit/?id=a64ac03a6146555f1847cdf43e3f86d14f6e506d
> [1] https://git.yoctoproject.org/meta-security/tree/recipes-ids/suricata/suricata_7.0.13.bb?h=scarthgap#n99

I do not intend to revert that change in scarthgap/rust, as the branch has
over 18 months of maintenance remaining, and I do not want to increase the
difficulty of backporting from oe-core master.  As well, I believe from
looking at what the suricata recipe was doing while fixing it for
meta-security master branch that overriding oe_cargo_build should not be
common.  I've been getting sidetracked from updating scarthgap branch in
meta-security, but I aim to get an update out in the next week or so, and
will work in a fix for this.

Thanks,

Scott

