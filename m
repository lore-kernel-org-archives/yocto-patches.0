Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886E9D2ECE5
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 20:38:33 +0000 (UTC)
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44547.1768855104407591863
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Jan 2026 12:38:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=mvMpilpi;
 spf=pass (domain: konsulko.com, ip: 209.85.222.193, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8c52e25e644so434117485a.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 12:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1768855103; x=1769459903; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zHPYx67T8h8dSjTK6UQc+lCtafYWkFjOhVxfGvt/qDs=;
        b=mvMpilpiWgD/UZtj905RSSaPRG7c6u9bYpbux2D2hdnfX1SMeouvcMDjXd3e0y8KTY
         fffIF6olXVqoMDAkr/V+z+Xn9QdCuA4GwGPxtRgdD17dH5jGSUbwml4NXc1Qcx2FpBgM
         4p7v7PmMfkThCEtk+MLSv6cR3aafVbQzUCwGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768855103; x=1769459903;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zHPYx67T8h8dSjTK6UQc+lCtafYWkFjOhVxfGvt/qDs=;
        b=mv6shw6XKmfeoHu61rVggBIRCxTD+vlkFYJZPqFuYYCmp3SNBKAcV622yQUvwMew65
         TplZL+a7mY00TYL7hPOadOftsMfvGg3YYSQYvWXZtyKazMhYD7q1gUyfvwgN7n5hTm+D
         Zadzcg0xdSqFE4HAa7/D6wfYVmcMwVjpLfqUVGdiqkPRi5aaK+k99RnRlh3pI+eEPL0V
         10cOl1lmSPNEpz5xeb6BPs5afOHV7d4g0zBF+wj42FEVGK3TxpC06U2lms0jyHZewv1r
         cxTkJL+LWZ5kFdx9wj0noHZac2wUVb/SAaBiOhUOc2MSVbfbWyb4u/rfvi6rwyHhTQH3
         yXgQ==
X-Gm-Message-State: AOJu0YwZDxGmHgfP76OaYjaSlZLgz3p6U0r7r7g5sXkcs8ajA46DvzMn
	CdN5poR1wXeGrogbgKWKyGzgMhZIaYfbbedLfLuAXgLXW9G72YtTt73c/avXJ9HeWL6J+40ORme
	hCcENyzE=
X-Gm-Gg: AY/fxX5P5+LjH3vFX4fr9dd22rldOnW1T5xYSc/e6bbwIer7DH5f6xzWTco8if2C7Et
	ux7TvOtR05lQ54kv6Gru4vLgBCcuizO1dvbymfIV8n7VSvXwDycaLymUM/nwhBAkKNh64rp1GHL
	Bt00Gs0PExRcPFJb4IX4Gigm3okPzuOsIHPByQjt/CsiuIEy7eDR09ARjEVUb5hsdB2M51LczQH
	ku4tCk5/LzdK3q0+P/0xmzkl44cMyCHXV0/HtdnNLc/NuN1qsYPJw1Lje2Da2UBCg7NyRkEmEEU
	DaL8yEaeB3SYLgL80gc1pqGFAW/DyeruVawdJ8YWI2E65uw1zpShPqD3+Qx1JuCxaueK6sYrxq5
	8tEAFVDST8w47SqmolskKfj6GUKC0cXrkc6BcvkckkVmVYG+TGHjeZxE6H6FegVECs8AKAsMNg/
	zka/5CUviXjwYF1kkDrvYGPgPTbnvQTzhTVGMpOKe8iIQvueHKRdGDSliNjCqZOVJ5gR5wcJnYB
	KNbZlPduMYLqLbkJcZaBByEDLKenNXtiEg=
X-Received: by 2002:a05:620a:4150:b0:8c6:a539:55cd with SMTP id af79cd13be357-8c6a693b0e8mr1579674385a.41.1768855103099;
        Mon, 19 Jan 2026 12:38:23 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71ab288sm899165185a.6.2026.01.19.12.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 12:38:22 -0800 (PST)
Date: Mon, 19 Jan 2026 15:38:22 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: Re: [yocto-patches] [meta-lts-security][PATCH 0/3] Assorted updates
 01/19
In-Reply-To: <188C3BD0ABF104BC.2815209@lists.yoctoproject.org>
Message-ID: <e8b6cd6c-63f8-20ba-4793-3e045f4b7617@konsulko.com>
References: <188C3BD0ABF104BC.2815209@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 20:38:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3022

Oops, these are indeed for meta-security, the "lts-" in the subject
was a cut and paste accident on my part.

On Mon, 19 Jan 2026, Scott Murray via lists.yoctoproject.org wrote:

> This patch series rolls up the contributed patches from the past couple
> weeks, plus a lynis update from myself.  These changes are queued on the
> master-next branch if you would like to check them out to test yourself.
> I intend to merge these to master branch at end of day tomorrow (Eastern
> Time, Jan. 20) unless there are objections.
>
> Scott
>
>
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

