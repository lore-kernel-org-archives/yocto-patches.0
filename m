Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2110E64016
	for <webhook@archiver.kernel.org>; Sun,  5 Apr 2026 07:58:42 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31515.1775375914126661614
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 05 Apr 2026 00:58:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=e+Ph+BQP;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488ad135063so1681935e9.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 05 Apr 2026 00:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1775375912; x=1775980712; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MqEAN/TF3x2pWteWVhQqdvoIMQSKw1vcd+bvkv89mco=;
        b=e+Ph+BQPRob02VKzWZshziDJBh4qXc5UJ9GvN/iPWNde03PyTF6IVlKKci5No0Q2ZM
         IZy9Z1toYhIqsOxEmMWgZOZPlA6586Utxpkd4xUPHd4tdGmkfdI5dzG2HtAG7KMze31v
         TXcetTaJjnLQAqHBzUEBWPfuxgnCrV6vTpAF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775375912; x=1775980712;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MqEAN/TF3x2pWteWVhQqdvoIMQSKw1vcd+bvkv89mco=;
        b=L9J4YqcId3VaE5Kr40FAEJ9L6LUPVB0UJT+dceo0n1ODwfnufAz41FWBCRRcvb3ylS
         HdOM+CAe3mSXNxFSRNDhXarp+6EinkcRSj783WZeieBolvEXR9NfaW8JNqGaRfv5UbiE
         9x6BWuzA9saqYB86Z5upLbb9MjHqbX9NIK/lGrDSyvXgX2hy0rHrxB/fFKNWThrGgkLm
         ri06rEftLVrGoH96JbDSlBSqGJB2b7zuiif9XJyFnZHCvtLswfc6SIvo2SkRrj7A9y8e
         SilSQmM25MqrxtcqkjhNN9C077fgBHrncwuMglO/Lxy5+6o74Iu/HdX0y/YWYMGIDQR4
         EH4w==
X-Gm-Message-State: AOJu0Ywofzp0I+jdSjeQ+a5lt5kv6hrmnXexlyYoSFaRwE4Rk9/jNm1y
	GSjBkkGA4xthhDW4UmW5QOMLoHcBgSSrWpjlqLwCopEf8EDPDjlVwMU4PE8gFFvHO7sEHQWtMuk
	6jF6Q
X-Gm-Gg: AeBDietvgltvtANxE+lSmNYEhHTQOL6y4Hq9iP72RgDbpogGl3JeMZ8jhBG54MR1ES+
	ufHb0QtcK3ckN6YTNIDqMxhdLGaaNs8em27HY4E1pBkOqT7b1PhVXUObjU9b3V05yUniz1QQTLn
	/o0fWKG9A3jKQT882xbiCBxL4frzsr23SLQMzVBxEvfvFpf5+oyk3+DB+PvjZ/EfgEk5cEPrB4/
	5Y6Kn2j096+KlqAMRHanQaIDw3QC5REZ+4Hce6XR1NByBj7+4vg7LRAm70wUeKZolksOIXC02lI
	8FfoVp/Vqb052ih1fKbbpoKqad7tCJIDOpb4rg7h1A58UnyRo9RqdZVbEZBBe2xfLth86a+8ikJ
	6DbUYQcY7GZgNKPpWHtzfoHKTfzDEijkxfdE33Q4a/zsmO2ZypMQiiZ1T1ZD5GxUxx3pkWEvH0O
	IaSb2xrRT2ahJXxIAUSTb4dgKWlGYS3n4zCsKUN5e9fw+zOH4DFLFhzdpJbv1TawteceqkmXNYL
	7spePbxJPcfC/Pz
X-Received: by 2002:a05:600c:4593:b0:485:3b00:f93b with SMTP id 5b1f17b1804b1-488997e7b16mr142839465e9.31.1775375912050;
        Sun, 05 Apr 2026 00:58:32 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:5e42:a555:17a8:9bbc? ([2001:8b0:aba:5f3c:5e42:a555:17a8:9bbc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488a9242d63sm60793485e9.13.2026.04.05.00.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 00:58:31 -0700 (PDT)
Message-ID: <6fba1aabc8dc22160ee8f242efc15e38229f222f.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper PATCH 0/2]
 janitor/ab-janitor: fix reliability and security issues
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Michael Halstead <mhalstead@linuxfoundation.org>
Date: Sun, 05 Apr 2026 08:58:30 +0100
In-Reply-To: <20260403-contrib-halstead-ab-janitor-v1-0-91b4bb47c0d7@linuxfoundation.org>
References: 
	<20260403-contrib-halstead-ab-janitor-v1-0-91b4bb47c0d7@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 05 Apr 2026 07:58:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3641

On Fri, 2026-04-03 at 14:39 -0700, Michael Halstead via lists.yoctoproject.=
org wrote:
> Changes:
> 1. Handling invalid pidfile data:
> Previously, ab-janitor could enter a stuck state if the PID file containe=
d
> invalid or unexpected data. These changes improve the robustness of the
> startup and exit logic, ensuring that stale or corrupted PID files don't
> block the service from running or cleaning up correctly.
>=20
> 2. Modernizing calls and general cleanup:
> The script was using older os.system() and os.chdir() patterns which
> posed a shell injection risk when handling file paths.
>=20
> Switched to subprocess.run() with list arguments to bypass the shell.
>=20
> Replaced os.chdir() with the cwd argument in subprocess to keep the
> process working directory stable.
>=20
> Cleaned up technical debt including bare exceptions, variable shadowing
> (file builtin), and unreachable return statements.
>=20
> Corrected a misleading comment where the math (120=C3=9760) correctly
> represented 2 hours, but was labeled as 30 minutes.
>=20
> These changes have been tested on valkyrie and verified across the
> cluster to ensure the service restarts cleanly and handles the current
> autobuilder environment correctly.

Thanks Michael, it sounds like a few things needed fixing in there!

Cheers,

Richard

