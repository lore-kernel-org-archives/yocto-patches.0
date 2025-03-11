Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09888C282EC
	for <webhook@archiver.kernel.org>; Tue, 11 Mar 2025 10:39:00 +0000 (UTC)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
 by mx.groups.io with SMTP id smtpd.web10.5636.1741689536582936726
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Mar 2025 03:38:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=C+6uFki7;
 spf=pass (domain: linaro.org, ip: 209.85.208.169, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30b83290b7bso57758701fa.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Mar 2025 03:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741689535; x=1742294335; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lgKzWdhjEKLA/tgTB4gMNHScKf0W0q9zF+3MlBuNPek=;
        b=C+6uFki7NbzXNPYvO0tO+0wOIicbWwf6P0WrgnLd9hngjKOlcK++d6QMy/KF0ZCOGh
         ak2jRU2pcyPLKziwG7PMN3O5ckNH5dq0nWLqELpjQc3rQud1zvvA5u/yAMS+BWd/up61
         PSeXigIExsjnsFttc+wnuFaiwJC0aWbaox+OLy4OCJa6X85DolUrE2ld1W0a9oDEjAuH
         WO4dzjq0CdOMnaorFKWmFxq/RwIBx9U5WD03q60jhBK8IE1iNAYtsEH9rZRyqJBcspSi
         nRj/l3JDG9v/XXW9t2lga2ZioSqhnc9FKzGHBsd05VXMUjRcaAXpdI3VOXtfThIjhcU1
         Psxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741689535; x=1742294335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgKzWdhjEKLA/tgTB4gMNHScKf0W0q9zF+3MlBuNPek=;
        b=Na/nje0VvtFWmIeHbIab7X2mgaAowjeU1irQ6DNw6RrTehU3Bs6LRt2/tt/ADLaR1F
         +cUZHaLmx9XPvSkfoy7j8lbuaJFtkv6xzFpcwcQppIWG9H1PEq61seUbUcDC310dATNN
         LlL0Y/bcNbqk+8xPM7Kua08cPZxbYBo25C7o2QRkbKlQGvnPdtpE6bea1FVbhIcAgvEe
         bZHEpLmMrWMkLc7OsYdCGHPQMG4KKoL/UTf21Xt7TgUGoqkItrHkXMyqlUs3T4B4jEA2
         D7vnsWC6a/vOFSfqzvbn00DnSxrTiOkE1OZoNWwgw/WU1DoLVQf3QKQYdBJne9hFbyGi
         7SwA==
X-Gm-Message-State: AOJu0YyGIsOT7V1KusFg219cPdIsj6YbKqicDAlAM/y758jRskYur0K6
	+5LwclPXMfCMPBd3ftbWJewhaoY0pVv3x5tIOPPa915Oaf4zOHRXMUyu6WjCOzVPc3ACDpbMegO
	BXfs=
X-Gm-Gg: ASbGncuMDaCRhc3gLlzKmS2BiWKvz1+s75VhZPcm2T/nwNp1OMJdkOl5F2bn3rO5RLO
	GMNs4NjdCUDFPvi+ZnHp1Lex4tHcEJtPCJ+uy2svzDpCeRvq+wi868SGwFA0pnGeqcrAtJ0wCmn
	OQelK+cJsq6s9SyhDnLj3T2EEa2cDb2LqUalTY5xOvxYJygXfX1OYoEBXnEH4VbXKgUNBSQ2OZj
	12aZIV0Ys70a0pEFR0k8novHQZ5vsyy+zKLperigIOS8WY45p9n4easMB/MMrHVhM9/1RjIPOh9
	jj0NNxJwGv0HaDb7Vsfhyn4x/JUOrYXI0z7rebF2lVwr0Jt+hrgAj2hz9+9nwvjAiJTdhg==
X-Google-Smtp-Source: AGHT+IHq3nb/gnC6UB6wyslJkToGdnKIGFjjwbpz0kPOduclnJVv+3JiDFex8DhF2xN0mR5dmlAmkQ==
X-Received: by 2002:a05:6512:ea5:b0:549:86c8:1133 with SMTP id 2adb3069b0e04-54990e5d301mr5588290e87.12.1741689534704;
        Tue, 11 Mar 2025 03:38:54 -0700 (PDT)
Received: from nuoska (78-27-76-97.bb.dnainternet.fi. [78.27.76.97])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae58e22sm1739964e87.86.2025.03.11.03.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 03:38:53 -0700 (PDT)
Date: Tue, 11 Mar 2025 12:38:52 +0200
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Omri Sarig <omri.sarig13@gmail.com>
Subject: Re: [yocto-patches] [PATCH 0/2] meta-tpm: Update python runtime
 dependencies
Message-ID: <Z9ASvGmKDxK08Jm_@nuoska>
References: <20250311103333.2972573-1-omri.sarig13@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311103333.2972573-1-omri.sarig13@gmail.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Mar 2025 10:39:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1180

Hi,

On Tue, Mar 11, 2025 at 11:33:31AM +0100, Omri Sarig via lists.yoctoproject.org wrote:
> When adding the package of tpm2-pkcs11-tools to my Yocto build, the file
> of pkcs11-tool failed to run.
> There were several different errors, all originated in missing python
> packages on my target platform.
> 
> I've added the relevant python packages as runtime dependencies to the
> relevant recipes in the repository, to ensure that the recipes are
> always self-contained.

Could you also extend meta-tpm/lib/oeqa/runtime/cases/tpm2.py
with tests to run these tools in some simple ways? These
dependencies may change with updates and would be nice to not
break them again.

Cheers,

-Mikko

