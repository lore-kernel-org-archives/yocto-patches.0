Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE7AD74EF7
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 09:25:05 +0000 (UTC)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16012.1769419502354159690
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 Jan 2026 01:25:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=BZVHGGqu;
 spf=pass (domain: linaro.org, ip: 209.85.208.170, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-382f9930e54so42760421fa.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 01:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769419500; x=1770024300; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p3+uckY1mS1Q6Rz5xakkS3YCSj0xRGIcp83GCjYi0To=;
        b=BZVHGGqueoORBrR2dnvOPIknBPxmePKt0eJt+AlQaTUTG63ZQ0nZWLhyP+rNaLoWJ0
         KJ2i2VzjC6Uzq/SgOQrbMf11tcDKVlmt7GAudQve4D1V+YCnqw7n5L9BwNH1Cmn3UJTP
         Vj3+oEZDpBVma+Wq6S1VrLpS0Hje31BqPFCek0fqhOYxlHSPf336iKWmAbK5wvW5MJX9
         eaqMrHFcigl8F4mlDb1oVg+XmkmMH51bquHL5ktdw/Vv54/toDlA6UyUn6Nc1v5RPyOZ
         g36/8IQh28eF8pdlbXJh6jB1iC0blWRubZNRpTbQhhDM8i31BdnLZInTGT6yZuKlDqEn
         hhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769419500; x=1770024300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3+uckY1mS1Q6Rz5xakkS3YCSj0xRGIcp83GCjYi0To=;
        b=sxgqsX9cytAVXKHAR195k4UhV72SJ1RMtKMw1RysrWqUDA8YXuDaR/LrCqTJPNHZGF
         NI7Nwtrls23lvNNEqTPcD/L0NFoD1v3erM/xsYfUudx5Jei44k4gyR+nWmJD8lX/2F/C
         VqJBXJ0pufnx4Yrj7SGJsebMcBu8hZC+26gzMT9ldvwLjQZBwUvbGJl0fZ36T0feS3L9
         5iskM3PtY/x1z7oICSxRunuujIDN46xyyD53+UvpgngshP2GybI+yDwlCkJdsZFsP1lJ
         TnJ6F3mOhBN0MXsQOCESGp1OYECHtwjIjBcq7QTYD7zwCq54QJtZgJJl7J7nn3yi4Uaz
         G2EA==
X-Gm-Message-State: AOJu0Yzyi0fYZKus7vNIai0lwCCCYxttceFm9tdOTljPcL1RiiXgyivP
	KSIyVHEnWaVWQxYVIxenzmbEXCeyM9l+mHYzNMSLYjwxwimXMcBwD3x9tLx8SEQWdyxhFTRxRQZ
	XmrWL
X-Gm-Gg: AZuq6aKJ3VI/TDSlTtQMxZg5ZV3akh5OPX/HA3seQn7X6JYmpu8ME/mRp4PVONwkNcI
	J5lZdvheRlrdIX2vU92Jt80xdhe8fBxjJDt5EU7d/UzVY1FBspzM+Hi9brPLV1YguJGmUiDYyxQ
	I4EZSCtNG1ozvseXYBIqJ8HnGb4xBotg6UgH74uZhA7WNTpl2OHOg4PdpBnByWOfiNqrj5D6KHo
	vQVKijc9XkW9PPAj+HDVFxs1UlKgJk8QzZa9vlPgxG+tIC+7zfRHVF1PwcqDqQ8eEG2Ju/jIsux
	ci9V4JykxlXTk5sZ/Yb3XT/ACG/7LUBoxwMmIOJX/9wP+azPOMBPWZpavzxqBoPIIj/kZ+T/9Rj
	HiXX6C7Psigxc7e5H8hVMy7Uwq9t/hCONP+e/JJTaexHb1HGqsMpAwX/NJVwouvKOFYbGsxABN8
	2UnMPV05D/h2HFoKMFMKOrOAv0YqDeg6n4M+7NROUBqMqb
X-Received: by 2002:a05:651c:198f:b0:383:1cd4:db91 with SMTP id 38308e7fff4ca-385fae6862fmr12246301fa.11.1769419500051;
        Mon, 26 Jan 2026 01:25:00 -0800 (PST)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-385da1daf40sm24591501fa.46.2026.01.26.01.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 01:24:59 -0800 (PST)
Date: Mon, 26 Jan 2026 11:24:58 +0200
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH] send_qa_email:
 add git-describe output if possible
Message-ID: <aXcy6iZSrBkErjvm@nuoska>
References: <20260126085252.178615-2-yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126085252.178615-2-yoann.congal@smile.fr>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 09:25:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3078

Hi,

On Mon, Jan 26, 2026 at 09:52:53AM +0100, Yoann Congal via lists.yoctoproject.org wrote:
> From: Yoann Congal <yoann.congal@smile.fr>
> 
> This would allow to quickly identify commits that are not on the right
> branch.
> 
> Partial example of output on my whinlatter-nut branch:
>   bitbake: 74f8a927ca6a20342072e5579182aea917b6dc30 (yocto-5.3-3-g74f8a927c)
>   meta-yocto: 6973ca663aaa9c3ab517ee960ab7985a5bf54c07 (yocto-5.3-1-g6973ca6)
>   openembedded-core: b4e7819b99d9c1a8995eba87e6f466fd8c77e14a (yocto-5.3-73-gb4e7819b99)
> (It shows that every commits are correctly after yocto-5.3)

The output may or may not work, and may actually confuse users:

bitbake$ git describe --match yocto-* origin/master
yocto-5.3-52-gcdd79c1768ac
core$ git describe --match yocto-* origin/master
yocto-5.1-4541-g6c31c2a73185
meta-yocto$ git describe --match yocto-* origin/master
yocto-5.0.10-40-gc23c19e0b300

and I don't seem to be able to find out in a few minutes which branch
of bitbake is used with core and meta-yocto whinlatter branches
since the branch is not called "whinlatter" but bitbake version.
Oh bitbake default-registry/configurations/oe-nodistro-whinlatter.conf.json
has it as "2.16" but openembedded-core doesn't seem to know which bitbake
version is correct for whinlatter.

I hope this works for "whinlatter" and other releases in the future
but the tags are a bit messy stil.

Cheers,

-Mikko

> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> ---
>  scripts/send_qa_email.py | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/scripts/send_qa_email.py b/scripts/send_qa_email.py
> index e3de4b5..8d24af5 100755
> --- a/scripts/send_qa_email.py
> +++ b/scripts/send_qa_email.py
> @@ -265,6 +265,15 @@ def send_qa_email():
>          # Need the finalised revisions (not 'HEAD')
>          targetrepodir = "%s/%s" % (repodir, repo)
>          revision = subprocess.check_output(["git", "rev-parse", "HEAD"], cwd=targetrepodir).decode('utf-8').strip()
> +
> +        # Add git describe output if possible
> +        try:
> +            description = subprocess.check_output(["git", "describe", "--match", "yocto-*", "HEAD"],
> +                                                  cwd=targetrepodir, stderr=subprocess.DEVNULL).decode('utf-8').strip()
> +            revision += " (%s)" % description
> +        except subprocess.CalledProcessError:
> +            pass # ignore any error
> +
>          buildhashes += "%s: %s\n" % (repo, revision)
>  
>      web_root = utils.getconfig('WEBPUBLISH_DIR', ourconfig)
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3077): https://lists.yoctoproject.org/g/yocto-patches/message/3077
> Mute This Topic: https://lists.yoctoproject.org/mt/117465359/7159507
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13178654/7159507/914336139/xyzzy [mikko.rapeli@linaro.org]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

