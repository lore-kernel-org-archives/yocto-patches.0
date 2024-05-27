Return-Path: <tgamblin@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA39C25B74
	for <webhook@archiver.kernel.org>; Mon, 27 May 2024 19:02:16 +0000 (UTC)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
 by mx.groups.io with SMTP id smtpd.web11.4881.1716836526411965365
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 May 2024 12:02:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=aXItBMgs;
 spf=pass (domain: baylibre.com, ip: 209.85.160.177, mailfrom: tgamblin@baylibre.com)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-43fb05b1ef2so396511cf.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 27 May 2024 12:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716836525; x=1717441325; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/aaevUSZeh+cCWabF+pLeSht42aXxuENDTQMVFlAL8I=;
        b=aXItBMgsUmBaawt6si8ToSGkJLcBph+RCnpSu1HihAc9BaPdjikrVWa0n2aNkOPKi1
         5IJKnWADT2c1rBgkGu58hVlUW4rAuO2RG+6CpM2k9XUy7v+qoxd+p+yOYkrJw8EOfLO1
         1fXTXA4as39c0NBkOaNGocT174wPsgl+u2TAm6hcSdQzU3ITUCml3U9hYwKfXj8RnbEr
         W9zVVXDm1ays8jYqUWpbKaSDp/mEcM40Ldo1avGcBvtggbwiT4+efNCA/lGW+Yb+CGWb
         2bxICrNgvwr2Q5fcHmOQvWPyUkw5c7GrQirFrBRmR8aBd2f+KlkB6DWaUBKpx986Ap79
         9sQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716836525; x=1717441325;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/aaevUSZeh+cCWabF+pLeSht42aXxuENDTQMVFlAL8I=;
        b=amKMllKM1cB19ZVo4zUcv1XSBaWp4hH6jCqFWWSqap6h5hEBeLWV6WJMEhMUJTNXlv
         S0I3MblS4z3/cswcXgsKka6eT8nZUbidZOyEAR7PYpMWRXGXK4jcwvQrgwQ3Rck2sGjq
         xYGId3ihOdGpaVfiuABCfZBefkBy85XCL3EqBEs8wxl94TwcqhmsBeP1XPEhOa8YlBRm
         QGSsQPcFEOkk8neIPe8SR7X4bRCNzO1IHmfReGvHIzFeDTiXf1jvjEaP8Y+XYLDyCW4U
         QgbpG4j81lJOg0IXHqHNJPZ4azPJfS2kT4yjkZsx5BAnn2Wq2rKoijvHco27HeECYJJI
         GiPg==
X-Forwarded-Encrypted: i=1; AJvYcCXMbTa3ZLgGT4NCst8OW9PGp89DG4QFYgIBuujpSCn1lJQJYbiZ2Fgd5YhWfuMwhtmUTE2n0P/mbcYg/HAFtuDvbuIiYPWclbnfd3ClA4zbLJankpE=
X-Gm-Message-State: AOJu0Yx8Dry5QJaOD04Spo+5YsMO0akbnI/izDXX+CBlooROUqqsFdGk
	i+9dwaZa3A9BebeLSO9TMeczCsK4Wf1T3638Sx4MKHg+u3Ue02JrhxwA92ixOG3LmqZBH86CTQ0
	r
X-Google-Smtp-Source: AGHT+IGU/SnCbbvmja2MbPUNu+xi1MYhBpmJmC+58i3LjxocTdOAXWl6g1Vi1BRcAZaBnPxYrjrXOA==
X-Received: by 2002:ac8:5993:0:b0:43e:3c3b:d9d1 with SMTP id d75a77b69052e-43fb0e74c87mr118942431cf.3.1716836525258;
        Mon, 27 May 2024 12:02:05 -0700 (PDT)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb18b0cc9sm36263101cf.69.2024.05.27.12.02.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 12:02:05 -0700 (PDT)
Message-ID: <81cbe515-6fb2-4342-8932-cb453a0bf8ab@baylibre.com>
Date: Mon, 27 May 2024 15:02:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [auto-upgrade-helper][PATCH] upgrade-helper: fix
 testimage check
To: Alexander Kanavin <alex.kanavin@gmail.com>,
 yocto-patches@lists.yoctoproject.org
References: <20240527175850.1256122-1-tgamblin@baylibre.com>
 <CANNYZj9NxxYo3jTYmNVhGPvv9VoeZN8M779TmDwfgsbDzdoEtw@mail.gmail.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <CANNYZj9NxxYo3jTYmNVhGPvv9VoeZN8M779TmDwfgsbDzdoEtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 May 2024 19:02:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/214


On 2024-05-27 2:10 p.m., Alexander Kanavin wrote:
> remote: ##############################################
> remote: Invalid author Trevor Gamblin via lists.yoctoproject.org
> remote: ##############################################
>
>
> I could probably fix this up, but perhaps it's better to do it on your side.

Is there something that needs to be set in my gitconfig or elsewhere?

Trevor

>
> Alex
>
> On Mon, 27 May 2024 at 19:58, Trevor Gamblin via
> lists.yoctoproject.org <tgamblin=baylibre.com@lists.yoctoproject.org>
> wrote:
>> AUH's testimage logic is still checking for BB_ENV_EXTRAWHITE instead of
>> BB_ENV_PASSTHROUGH_ADDITIONS, and INHERIT += "testimage" instead of
>> IMAGE_CLASSES += "testimage". Update it so that checks for the correct
>> variable names.
>>
>> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
>> ---
>>   modules/testimage.py | 2 +-
>>   upgrade-helper.py    | 6 +++---
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/modules/testimage.py b/modules/testimage.py
>> index 0fc1adb..fb2e467 100644
>> --- a/modules/testimage.py
>> +++ b/modules/testimage.py
>> @@ -53,7 +53,7 @@ class TestImage():
>>           self.logdir = os.path.join(uh_work_dir, "testimage-logs")
>>           os.mkdir(self.logdir)
>>
>> -        os.environ['BB_ENV_EXTRAWHITE'] = os.environ['BB_ENV_EXTRAWHITE'] + \
>> +        os.environ['BB_ENV_PASSTHROUGH_ADDITIONS'] = os.environ['BB_ENV_PASSTHROUGH_ADDITIONS'] + \
>>               " CORE_IMAGE_EXTRA_INSTALL TEST_LOG_DIR TESTIMAGE_UPDATE_VARS"
>>
>>       def _get_pkgs_to_install(self, pkgs):
>> diff --git a/upgrade-helper.py b/upgrade-helper.py
>> index 869dc3f..e307d60 100755
>> --- a/upgrade-helper.py
>> +++ b/upgrade-helper.py
>> @@ -262,7 +262,7 @@ class Updater(object):
>>           enabled = False
>>
>>           if settings.get("testimage", "no") == "yes":
>> -            if 'testimage' in self.base_env['INHERIT']:
>> +            if 'testimage' in self.base_env['IMAGE_CLASSES']:
>>                   if not "ptest" in self.base_env["DISTRO_FEATURES"]:
>>                       E(" testimage requires ptest in DISTRO_FEATURES please add to"\
>>                         " conf/local.conf.")
>> @@ -271,8 +271,8 @@ class Updater(object):
>>                   enabled = True
>>               else:
>>                   E(" testimage was enabled in upgrade-helper.conf"\
>> -                  " but isn't INHERIT in conf/local.conf, if you want"\
>> -                  " to enable please set.")
>> +                  " but isn't added to IMAGE_CLASSES in conf/local.conf, \
>> +                    if you want to enable please set.")
>>                   exit(1)
>>
>>           return enabled
>> --
>> 2.45.1
>>
>>
>>
>> -=-=-=-=-=-=-=-=-=-=-=-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#212): https://lists.yoctoproject.org/g/yocto-patches/message/212
>> Mute This Topic: https://lists.yoctoproject.org/mt/106334515/1686489
>> Group Owner: yocto-patches+owner@lists.yoctoproject.org
>> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13197349/1686489/315264618/xyzzy [alex.kanavin@gmail.com]
>> -=-=-=-=-=-=-=-=-=-=-=-
>>
>>

