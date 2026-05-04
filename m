Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0069DFF885A
	for <webhook@archiver.kernel.org>; Mon,  4 May 2026 08:14:05 +0000 (UTC)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10176.1777882443286702447
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 04 May 2026 01:14:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=aiYkL9xG;
 spf=pass (domain: gmail.com, ip: 209.85.160.181, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50e5dbd8e0eso42279951cf.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 04 May 2026 01:14:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777882442; cv=none;
        d=google.com; s=arc-20240605;
        b=NOxCDdwqqx29dNAjGFpn6o7p3y1aHQGmk5CIDIuuaSTBSaDPi60LDekKNx7M1xyDZG
         C477e6lcbDvKZL73BZaL4gnvQRIbnwyXO20ZXEgHDd8cMv64B94H9LHM0qKjAv5kXKZx
         SuS1Ljv3MBtCRlN3s/rCGoviNPV34K9A72ICccAVutzwptx4SPuu6amEYXkUAiDNtDQz
         hNLL5B8qt8/q+nAx1yDJfrwejBGnVT8OpQbYtIf8P8wLmJ3z8Z7d7rIXN8wDy9j9Vnbj
         W1HAinLdr9NyeJuEQydncor3XKKr4qJIf9/hqyCMbQmXXwbRSqcygURQonUll5Izyo+e
         sdEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BhWQuRiHbtXaHuqyo/B9XOfKxCuknL+3pnwbc4Syk6Y=;
        fh=B6+dp47eghNzyj8BrWGHk2n/ObAtmJy/gW8Hzrmb+f8=;
        b=TzAfDt16FwmH1v2tp69lvz5VuK1WojYQ+7SfTmWkllnC9AIyv8VIKIVv1NILZQ9wte
         Flm9/costEuv+dHPCA7Ldw82a3C4xrO7pBtW6R0pnZdPGBXxz/CY06hG/0dar2Pt70Ir
         PABL5/EyjY3WDcvwv27y75vIdfOkEwXrEldz6GudptccIjrVgVBAjM8zra4msWjr4/M0
         a1b/4fjUF2t+Ap9ITgUJj85sMnNa9Ze9KCXHgiBrMnNcpBEkn9fLlC+PaJ3QmClA4pYr
         xj6XItoOtEZCKwqZSSS14iBJ+DHHnyPXO5/HN325/W6Mey589Ci4ZdCD8cFbu+xxEX39
         ZiEA==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777882442; x=1778487242; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BhWQuRiHbtXaHuqyo/B9XOfKxCuknL+3pnwbc4Syk6Y=;
        b=aiYkL9xGMNp40BNQbWBorT6ZnRqy7QYZjRcXYt0JO+8YzTPHWhBrPrkTP9SvPoa6S+
         zDX7OLU5TWjmG6TNvVA0dpQEnzZ77/D+k97Z52080mJFu2RWSNry7Dm7w533ExL5lKUl
         vgtxl3A/ik3jqhfNVdAjU1+/IMWrujEnN4hDsjm/idznxUf3+/13SXKbaQrPHVEYy+UP
         fb5gChDw4B0RxD/qbFmAj0osxDQp08gkcDQv85RdLp+Qz3G9Upc59nxz057n4diScyEv
         CIjLgnOvvlNvEXowk8IpIYsNbq/C/BKhbY2vQlRurNlO5duUFFzjk6I6OOao+uCx/mLW
         6ExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777882442; x=1778487242;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhWQuRiHbtXaHuqyo/B9XOfKxCuknL+3pnwbc4Syk6Y=;
        b=BHt0EvnptnD/p5SWIvlBZvODeIE/LsqZYVbqO3CnbSdb/ILUOsv50PwzCKQ7u0wDf4
         +9pKpQiIixxvzNBVpcaigOKD0/wXzVcHJ0ES531pIeyhHMrcqZJcj6oSrT5NTJzLT94J
         LG3hQIOg+h8r94KuhDvivgO9Et+wU26cFkHcqnTEK27sRJiJaboAx9JZH0vVzZIQZ1Wl
         gz72EcDHa3xeYRJEJlJpbpLdQVSnrLukm9Od9U3ExJ1G30E0bstNv0rTR5uJQBFrBuCF
         akyGLZ9zlU6uEPKXFhHFvQv4uIL9CixgqOhQLC72cDzqYeI1zDaZRPoMZilSOEs9Sit+
         yelg==
X-Gm-Message-State: AOJu0Yw9HBtgMcZcUpcWOWSXj18K8+p/26NCtn+9TAiYYmGXa/TH0/aL
	huCSgkbp2UPw5Q/nrdOt9e29zaEiFaSGBvHK2MB1XX0GSwv0zDchuBMiy2mnlrF0ni67MA1vqfc
	DezlKQ0z1OzmEzmXIX6tYaMFP3DXIWAM=
X-Gm-Gg: AeBDiev6F3iucrdQqa9KrHPFOsjddI5MLucvQvH+WcejZJmwdKcRDiLtKanPhtGgeIL
	K15xKLhdBp1hyG5t2UfoKqDfPQNOLIq0LwzHaf7SO0R1OEjpAYIBpB/XpMV8lMCSamWk2j040Go
	4FMWbUAJU7C+ePPfoVqgK+CX6ux/EURpqc6Roq+F/KECQq1PjjDJfzPsmGwiOb04gFzRxMjiP6g
	PIA/m8oSWNdQuNTyIBvlh4IwpkEe4O5EOn5rIR+0l6fx0GRFnLI+ia8OruzByevp8LHJBcZm5EK
	XDu7+pQEP/Md9Sd6x04XlKL/c6rMpPTbO2+c6pOw+4+qGYb63mBu
X-Received: by 2002:ac8:5a0c:0:b0:50f:ade2:2e0 with SMTP id
 d75a77b69052e-5104bf3b91cmr127765821cf.39.1777882442304; Mon, 04 May 2026
 01:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260504063614.3831203-1-daniel.turull@ericsson.com> <20260504063614.3831203-2-daniel.turull@ericsson.com>
In-Reply-To: <20260504063614.3831203-2-daniel.turull@ericsson.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 4 May 2026 10:13:50 +0200
X-Gm-Features: AVHnY4Kk-hzBZPn6H-Oh61_CTBW6Sf6gGB7wurdd7JbW6YM_qdiA1-5TXQi3iAc
Message-ID: <CANNYZj-QYHE_YJcEtP7zvzeX+KX7iiJHOa_Biyq5bZUqzwxgMg@mail.gmail.com>
Subject: Re: [AUH][PATCH v3 1/4] steps.py: resolve symlinks in recipe_dir
To: daniel.turull@ericsson.com
Cc: yocto-patches@lists.yoctoproject.org, paul@pbarker.dev, 
	ross.burton@arm.com, yoann.congal@smile.fr
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 04 May 2026 08:14:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3908

Thanks, this has been applied.

Alex

On Mon, 4 May 2026 at 08:36, <daniel.turull@ericsson.com> wrote:
>
> From: Daniel Turull <daniel.turull@ericsson.com>
>
> Use os.path.realpath() on recipe_dir so that git operations work
> when bblayers.conf references layers through symlinks (e.g.
> meta -> openembedded-core/meta). Without this, git add fails
> because the symlinked path is outside the git repo.
>
> Assisted-by: kiro:claude-opus-4.6
> Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
> ---
>  modules/steps.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/modules/steps.py b/modules/steps.py
> index a6ec341..b3ec61c 100644
> --- a/modules/steps.py
> +++ b/modules/steps.py
> @@ -36,7 +36,7 @@ def load_env(devtool, bb, git, opts, group):
>      os.mkdir(group['workdir'])
>      for pkg_ctx in group['pkgs']:
>          pkg_ctx['env'] = bb.env(pkg_ctx['PN'])
> -        pkg_ctx['recipe_dir'] = os.path.dirname(pkg_ctx['env']['FILE'])
> +        pkg_ctx['recipe_dir'] = os.path.realpath(os.path.dirname(pkg_ctx['env']['FILE']))
>
>  def buildhistory_init(devtool, bb, git, opts, group):
>      if not opts['buildhistory']:
> --
> 2.34.1
>

