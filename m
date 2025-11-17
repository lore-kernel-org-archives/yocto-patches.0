Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B2DCCD19A
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 01:01:49 +0000 (UTC)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6313.1763341307757511656
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 16 Nov 2025 17:01:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=A/MjPIpY;
 spf=pass (domain: gmail.com, ip: 209.85.166.50, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-948f8fa9451so27430939f.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 16 Nov 2025 17:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763341307; x=1763946107; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fqx4+nyWNffePAXFQTlRf/iiuLoqjscSLbWl7PSCkT4=;
        b=A/MjPIpYFXYxTpNhszB90nB/spJ3tjcjg7SYmGwx3Iv4HxHwImaRvmQzF+Qkd4w72B
         ZiJ3XvABG7FFWqOpKF95b+obGrnchZ/Qdf8k5+jV8jTlMLRAtf49zuUHjkJLsjN41FXs
         LAAu8V9/GKKH+gXtZKI8pivvAKmQcPHAhb6L0cT9XvrOjwx0zeYkqjh1oqTGb0Mt68sp
         cBpRLSvUcRMHOOmCRPwWjPp4P4r4qEqR1s8s3FcwEQ1a7JuZhsTt8MK3Eyr5N86z3I7Q
         2vRJQtWy1zHp/FU8lQAes5WUeO/XJ8rg0/UR64+i9/D3Q0WK16u50Y3D7Dw1WSctWQ4D
         8tGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763341307; x=1763946107;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fqx4+nyWNffePAXFQTlRf/iiuLoqjscSLbWl7PSCkT4=;
        b=WI40na5Pty8etWJ83AVu87WR0l8wFcAWxh4da9GlqfDMxDqoKnAj6hkOccFXjGa0js
         W9i8ypMmJNsrot61yK2uAB7+ZQiObbcCfGD9aCDQGSoDkF88QU9FuOa0XsTODAvtTcJ8
         eYpcOGnfwvuqMckjp3aJ6KGl+nNQzveMvDO+SUVfm36HOD4ERohgWJu3gggsaxHyd6k4
         dMbmzEMVo4ArftGZSyznOJs2Kur0P6j9KYHSki40I4eR+/PZPX+zUcfIDq6S8fKL41MA
         AwJSnOlzidVezUbCEOMZMJg1Y1nk72N1nZgZnDp8tpDjzEdsDx6e7WMU+nNcMoz8I/ND
         zX/g==
X-Forwarded-Encrypted: i=1; AJvYcCVaeLSsHVk109US5WFEWT5OCTLTGuIFRoVfj0IJlMVQUlQ7wxywgz3eVPtq25omt8nx5MV6FPcTj/I3TF7b@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YwXVD9TuWWq0XbyWTONGWLxNELLL3IS3B5TI8FMSc5/h2aB5G7x
	5szkyi7/tLHCcsBuWEAelUJQWd6qkP6fzrfenDNq/+r5Tc8ZC0FsqWGq
X-Gm-Gg: ASbGncvqUzsmd/AZ7e0Tr2svkw+Kogf76osXpmQCNfJ+oVSFr+GtXlpZRzfKant6HbR
	PfpKq5MfQ0BqPrcQgWPSeWxUteVEjmnj2LdzeOSowSw0Pzd975BH8pPA9lc+eAMyC0JNNk9QvH1
	NIP7toK0K31SAeFiqWiWTm4c/MKMoNYqQPlWeYigqhHK6GgRYTmF9waLDfZLPsbGgKZczwE4+Ii
	H9OsIXMqBtAeUGQ69kA6zQu/2LRE9wNiW7YwtvfmYqhmYQ6l8d+WX2DJJYMAAFM94b05QfCutN3
	wmLpG+3vhzKse0w5tkwpMtDsUXiy9y15vyisoaZacN6h7y+R7anPLsgKQHpUVZ2zBT3ILBfPgOO
	9GtSd0Oo6Ewqy8GY03JYcDjhSApK751soOau7shD7JS7mQ2jFRdQCU4G2X86NCHeIhqovARYrjE
	MepoWLSaWjcRfxuF1V4TIKNIB7HLlFi9FqxYDzeLJA18pSNw1aZBeFNwCdQ+PlalK7i5cZoNYg
X-Google-Smtp-Source: AGHT+IH8ehOQsrkLMufP6LHAhSHCp42Bi/qWh/it0X1IJw2Jkdz8PaX4h4R0A+T4dgBEEIW+7KNuHw==
X-Received: by 2002:a05:6e02:3181:b0:433:7c77:be5a with SMTP id e9e14a558f8ab-4348c939ad9mr174449715ab.28.1763341306852;
        Sun, 16 Nov 2025 17:01:46 -0800 (PST)
Received: from [172.26.252.3] (75-166-169-44.hlrn.qwest.net. [75.166.169.44])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7bd315e4dsm4017165173.33.2025.11.16.17.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Nov 2025 17:01:46 -0800 (PST)
Message-ID: <c368e7bb-248f-4762-9db3-f7771e9bc69c@gmail.com>
Date: Sun, 16 Nov 2025 18:01:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-security][PATCH v4 1/2] clamav: Add recipe
 for version 1.4.3
To: Hemant Jadhav <hemant.jadhav@emerson.com>,
 yocto-patches@lists.yoctoproject.org
References: <20251114154052.3651845-1-hemant.jadhav@emerson.com>
 <58f6364a-0faf-9296-588e-1798cb52653c@konsulko.com>
 <465076.1763152233932443580@lists.yoctoproject.org>
Content-Language: en-US
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
In-Reply-To: <465076.1763152233932443580@lists.yoctoproject.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 17 Nov 2025 01:01:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2577

> [...]
> I am reworking the recipe to use the proper cargo vendoring approach. I've looked at the Suricata recipe in meta-security, which uses cargo + cargo-update-recipe-crates classes. I can rewrite the code.
I have been working on the Suricata recipe lately.

FYI in case you run into into similar troubles with update_crates.

Cheers!

Watch for non-crate SRC_URI components.
I've also seen SRC_URI being set (=) instead of added (+=).

I think this is part of it:
https://github.com/OISF/suricata/blob/suricata-7.0.12/rust/.cargo/config.toml.in

Workaround: Run do_configure before update_crates

Issue: "ValueError: Unable to find any candidate crates that use crates.io"

Workaround:
diff --git a/meta/classes-recipe/cargo-update-recipe-crates.bbclass b/meta/classes-recipe/cargo-update-recipe-crates.bbclass
index 3251d5ef2e..f63b231eb3 100644
--- a/meta/classes-recipe/cargo-update-recipe-crates.bbclass
+++ b/meta/classes-recipe/cargo-update-recipe-crates.bbclass
@@ -69,7 +69,7 @@ for root, dirs, files in os.walk('${CARGO_LOCK_SRC_DIR}'):
                 cargo_lock_path = os.path.join(root, file)
                 crates += get_crates(os.path.join(root, file))
             except Exception as e:
-                raise ValueError("Cannot parse '%s'" % cargo_lock_path) from e
+                print(f"WARNING: cannot parse {cargo_lock_path}")
             else:
                 found = True
 if not found:

--
Clayton Casciato

