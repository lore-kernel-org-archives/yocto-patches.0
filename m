Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5704.1793786314732271555
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Nov 2026 01:58:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=avm4T9+T;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: ghidoliemanuele@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so3834005e9.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 04 Nov 2026 01:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793786313; x=1794391113; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:to
         :references:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QeFohobjbWTkRocLVluCcb/x8SKpeVMRBQgXuNbQWHg=;
        b=avm4T9+TfGwRE9PrPliIoXrMV7IswUNz79dxbM2wo35Ry59M3E48g7q6kuTpmnQUJz
         lSlbCBy7xgnorXKxEJvfXnzcblIbxWzWcAOYZb7JWcg8Uxt5Cl+Qj9OzYvZ5B7Q9Py/k
         +AuDSXpM0Q6MoKlD23HD6/rlVcgv9t7G98qNbVq5yGxh28zZ8A+n/mQAnUDZLBU8Ivma
         xWAByaF/BFjDtABMWgtWs8X4Yl7JNgICGig7Fkw6fjDVD1nw9GOaZ4UVu54OurwmLv+Y
         Mz9rXoImkMH+UnRv21wxmQPf19OD39BHF/hUlVGHRY+iiCjKuA7bfBN/R4IqhCZJ/sLU
         R+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793786313; x=1794391113;
        h=content-transfer-encoding:content-type:in-reply-to:from:to
         :references:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QeFohobjbWTkRocLVluCcb/x8SKpeVMRBQgXuNbQWHg=;
        b=AlOsTuipoEEB6kFXa9/LQxIe/4EXCb4xH0fT/YKZvXe0LWnt+Vrwj047c13EQYnJpD
         IH5lSYY3qPFs8IzJJwjZX0qDjZkAIX+1GP1Srr51Gnwts91F+Dvgsdr/Ptu6M0SUCpMa
         KWQ9t6GsJLO1eksDSjDYboOtBX0QfsjWyd2A1NOXp8G6cZkR1MsrmOaebN9Mayi5e0f0
         Hp0AsvWXegQpK8syQb3EHYxbUPgKhiRfTP/ft7Hm1pKwlbFNg7udnH5XRzXNNbr1qxYA
         xkJbgoboiNZ5TY6ltdGN8LWJkLyOfozVzOVbxqsee1kiO5SdJzA/Oaxh48uDQxHiE3gm
         7CxA==
X-Gm-Message-State: APuU4Z9f6+xRP0hpfPYA1d5sFw4aQD9O8mJAEuFBJOJ5XLzd9ly9Uo3L
	UVSJ6KFWfRIpmro9uaYvYvV1SA08MXiyAa4k7xa96OfopUG9GGqZxMFkMdSlXnVWIFg=
X-Gm-Gg: AYBFou2ohz/1yhI4fGLKWQsfWhLJh51a/ztfQwSOs63ubaPz1mQCrMKxsw5pv9ukRPN
	Tv2RDL6ZNJkHzM6iB2fhJ/82VBXcTXLtXsIab+PsY1wzKvVG6+92zw+aZv5Rq/X0dsQHzcTPRrk
	VZpqF1ZObWpBZx3zIqkczRDauOCpV4mujIDfXO+k5f8pT2O67k6IIiNiK0sn6NAMT6BDtKHl1Rp
	LCq1nMexkI9HHwErkh6dwmQ8b48Yc9+qern9hJu+tsY1i8dUBXMMStJmKvQwuHfGQ6/suU1iT83
	MgU8TUx8/81rs1iPPKf5FyGAhEza1aOXW2eqllhGALLPhCgvBoXstHFnTQdgpdJyyyOTwVBT4MH
	v3PmB4i5hstbC+OaRc0OB0MY8DvISwDjEj1wKsmLGQTJ85fr4+hdzJr0jMU0W1k/e27tqo1Manm
	kJA5cDfEfqUpNb4NeeZQXZlRGnhAUkBiCYBmwIVGeHRF0YKZ+nvowUXVRrpdHWMDutVh3UJu2eP
	wto04Jc8RsX8JWa2tLgaR4e2DHZiAmuqkj8JKhXVx8YTPmXF0k2H+r+sCXVvqpr4gK9yqmZuo2M
	KSbhHW4NQSliW6q/i87MCVpSFiQPLiRmSk0tE7bPO51KcKsggOBfN+U0uYNGivScfsOkqbKKaA4
	19PiH/dxMCmtt9IT3rfKZ
X-Received: by 2002:a05:6000:4b03:b0:48f:cb37:3ec3 with SMTP id ffacd0b85a97d-48fcb3768b7mr3529988f8f.41.1793786312670;
        Wed, 04 Nov 2026 01:58:32 -0800 (PST)
Return-Path: <ghidoliemanuele@gmail.com>
Received: from [10.0.1.67] (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed92a753sm3348606f8f.45.2026.11.04.01.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 01:58:32 -0800 (PST)
Message-ID: <2532fb3b-b6cf-417a-a0ea-a3cb25eed32c@gmail.com>
Date: Wed, 4 Nov 2026 10:58:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Fwd: [PATCH] tpm2-tools: Fix build
Content-Language: en-US
References: <eeb340a2-81d2-4a28-bfba-418a46001e3e@gmail.com>
To: yocto-patches@lists.yoctoproject.org,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
In-Reply-To: <eeb340a2-81d2-4a28-bfba-418a46001e3e@gmail.com>
X-Forwarded-Message-Id: <eeb340a2-81d2-4a28-bfba-418a46001e3e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 04 Nov 2026 09:58:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5231

On 11/3/26 16:18, Marcel Ziswiler wrote:
> Fix the following build errors:
> 
> ../sources/tpm2-tools-5.8/lib/object.c: In function 'PEM_read_bio_TSSPRIVKEY_OBJ':
> ../sources/tpm2-tools-5.8/lib/object.c:28:1: error: implicit declaration of function 'ERR_raise' [-Wimplicit-function-declaration]
>    28 | IMPLEMENT_PEM_read_bio(TSSPRIVKEY_OBJ, TSSPRIVKEY_OBJ, TSSPRIVKEY_OBJ_PEM_STRING,
>       | ^~~~~~~~~~~~~~~~~~~~~~
> ../sources/tpm2-tools-5.8/lib/object.c:28:1: error: 'ERR_LIB_PEM' undeclared (first use in this function)
>    28 | IMPLEMENT_PEM_read_bio(TSSPRIVKEY_OBJ, TSSPRIVKEY_OBJ, TSSPRIVKEY_OBJ_PEM_STRING,
>       | ^~~~~~~~~~~~~~~~~~~~~~
> ../sources/tpm2-tools-5.8/lib/object.c:28:1: note: each undeclared identifier is reported only once for each function it appears in
> ../sources/tpm2-tools-5.8/lib/object.c:28:1: error: 'ERR_R_ASN1_LIB' undeclared (first use in this function)
>    28 | IMPLEMENT_PEM_read_bio(TSSPRIVKEY_OBJ, TSSPRIVKEY_OBJ, TSSPRIVKEY_OBJ_PEM_STRING,
>       | ^~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>

Tested-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>


