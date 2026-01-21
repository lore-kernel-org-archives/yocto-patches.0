Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891DFC44536
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 14:56:42 +0000 (UTC)
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13598.1769007394089990812
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 21 Jan 2026 06:56:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=MddVcwXX;
 spf=pass (domain: konsulko.com, ip: 209.85.222.196, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8c5265d06c3so103824485a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 21 Jan 2026 06:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1769007393; x=1769612193; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bBynEGAMegGRi+a7ckl3M/HnW2LJo4mAjMu/kLjwFNQ=;
        b=MddVcwXXap5qX8WnuTVZsW1fsx6cack9OZmHoOp4ySlOKfoqBCCHruKkXHbC46cr+8
         8z1fN/X93OAGws4ln6jhhk+SgMjw5IuWloegm3QlFSTCg252aSSw6NyzDxisvbyif8oj
         48GOo5HZhTctggdd5DC+dKI3X5DWtoI9o4mgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769007393; x=1769612193;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bBynEGAMegGRi+a7ckl3M/HnW2LJo4mAjMu/kLjwFNQ=;
        b=DwtdHnFzOLaNVMXIQtD9mVtMIE+OHYGKRXQzZ8pYlKp68FbRUh8WCq1Q6hZeTGUPYG
         PFPfTIizke7CH422ktVkPUt3M/3BC6+6Usy0LKN6k5TtqBzF2zlyyVLsW3Hm0+pRBiEB
         5SmHXZ+pnE4W2BJRoppm7Cu8RjFeiMnG8SqVmbPVMaglJUJB4DfeTGjq4Uz06QfAz6cK
         GYmELy9B7CfedMHol79ryB7zkdPaCfVp3G6hPFah2YyyraPHodpHHvC0zPv2pMoUporN
         iO4zOdKUbHR698czY19GNaANHNf48A0OPNk2rmVouNqtdaWqO+wkJilSsmhjag4Ixsd0
         me8g==
X-Gm-Message-State: AOJu0Yyn/VUkylLPgqYxkdFs2yQibERMgW0CAWYQDPnOBAtja+KB+4se
	k9lOkCNtABsJ0/Caw4ZF9FwolEvx+fSI+jFlKMbTHekl5aaaAKgbZLikQdtLcig1kZP6ICmRymE
	Dze8J/YM=
X-Gm-Gg: AZuq6aINrnEeDU0O2aPwNrQuj2+grcDI7Jk1Y59bR2xgSQxhSM2x3QmGJmLxNPE9iPO
	FpZbAzNyUR/f5qCm/AGRg72AKzETy3hKlhycbuzyMLL+2LiXypmf2lAPmchV/kYRoWc0okcltgJ
	f1boSmyjpt1CY0jdY7WhJYVAyOs49MYqq2EF3BGITJzb4O8T2riYZnO5LtJnmD1iV8cbugy4klE
	/qWZzTK6IYcIowvfKfxW00cQBCjTq2UNxSkOyiTwEzX62w2e9HNaWo7gjQYa6CBw3oKGU89I8RN
	hJmEfPvBHv4WSH40kEeAIgz75V6H9zBiSMfhh8HE3NLlD4qvLutdwXZHJvez53XYkr9xcHbZmzj
	19mpNogWSxKx0B2Z4uSK2TD3PLmZZDHBF+0unCpTR/nhMEMC7+rOYpP6/9x2jEUGpec1mvAQoad
	mkKaARMpcSzcdrA1W9Xn4GmFk0kId4qY1q2kvU+g7yHTMZAfQN7ItL6i1iPMNsISBo/Whn+mNr9
	hn4RUaLcvfIxBUVNFiIkfdD2FoYgqihSDabwp2bTZiOnA==
X-Received: by 2002:a05:620a:7083:b0:8b2:e1b5:a4d5 with SMTP id af79cd13be357-8c6a647a05dmr2562520485a.16.1769007392726;
        Wed, 21 Jan 2026 06:56:32 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6cb46fc35sm415372385a.13.2026.01.21.06.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 06:56:32 -0800 (PST)
Date: Wed, 21 Jan 2026 09:56:31 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: Re: [yocto-patches] [meta-lts-security][whinlatter][PATCH 0/3]
 Assorted updates 01/19
In-Reply-To: <188C3BFF15A14E90.3354624@lists.yoctoproject.org>
Message-ID: <4c818842-fa55-66dc-121c-976507ba0b74@konsulko.com>
References: <188C3BFF15A14E90.3354624@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 21 Jan 2026 14:56:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3040

On Mon, 19 Jan 2026, Scott Murray via lists.yoctoproject.org wrote:

> This patch series rolls up the contributed patches from the past couple
> weeks, plus a lynis update from myself.  These changes are queued on
> the whinlatter-next branch if you would like to check them out to test
> yourself.  I intend to merge these to master branch at end of day
> tomorrow (Eastern Time, Jan. 20) unless there are objections.

These changes have now been merged to the whinlatter branch.

Scott


> Changes:
>
> Clayton Casciato (1):
>   suricata: add PACKAGECONFIG[seccomp] - MemoryDenyWriteExecute
>
> Scott Murray (1):
>   lynis: upgrade to 3.1.6
>
> Stephan Wurm (1):
>   dm-verity-img.bbclass: filter units from value part
>
>  classes/dm-verity-img.bbclass                     |  4 ++--
>  .../lynis/{lynis_3.1.5.bb => lynis_3.1.6.bb}      |  2 +-
>  recipes-ids/suricata/files/suricata.service       |  1 +
>  recipes-ids/suricata/suricata_7.0.13.bb           | 15 ++++++++++++++-
>  4 files changed, 18 insertions(+), 4 deletions(-)
>  rename recipes-compliance/lynis/{lynis_3.1.5.bb => lynis_3.1.6.bb} (96%)
>
>

