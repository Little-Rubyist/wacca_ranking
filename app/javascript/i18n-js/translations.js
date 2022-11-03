import I18n from 'i18n-js'
I18n.translations || (I18n.translations = {});
I18n.translations["en"] = I18n.extend((I18n.translations["en"] || {}), JSON.parse('{"activerecord":{"attributes":{"song":{"can_play_offline":"Can play offline","diff_type":"Diff type","difficulty":"Difficulty","genre":"Genre","music_id":"Music ID","ruby":"Ruby","title":"Title(Japanese)","title_english":"Title"},"song/diff_type":{"expert":"Expert","hard":"Hard","inferno":"Inferno","normal":"Normal"},"song/genre":{"2_5_dimension":"2.5 dimension","anime_pop":"Anime/POP","original":"Original","tanoc":"HARDCORE TANO*C","touhou":"Touhou-arrange","variety":"Variety","vocaloid":"Vocaloid"},"user":{"display_name":"表示名","name":"ID","password":"パスワード","password_confirmation":"パスワード(確認)"},"user_score":{"achieve":"Achieve","score":"Score"},"user_score/achieve":{"all_marvelous":"All Marvelous","clear":"Clear","full_combo":"Full Combo","missless":"Missless"}},"errors":{"messages":{"record_invalid":"Validation failed: %{errors}","restrict_dependent_destroy":{"has_many":"Cannot delete record because dependent %{record} exist","has_one":"Cannot delete record because a dependent %{record} exists"}}},"models":{"song":"Song","song_score":"Score","user":"User"}},"date":{"abbr_day_names":["Sun","Mon","Tue","Wed","Thu","Fri","Sat"],"abbr_month_names":[null,"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"day_names":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"],"formats":{"default":"%Y-%m-%d","long":"%B %d, %Y","short":"%b %d"},"month_names":[null,"January","February","March","April","May","June","July","August","September","October","November","December"],"order":["year","month","day"]},"datetime":{"distance_in_words":{"about_x_hours":{"one":"about 1 hour","other":"about %{count} hours"},"about_x_months":{"one":"about 1 month","other":"about %{count} months"},"about_x_years":{"one":"about 1 year","other":"about %{count} years"},"almost_x_years":{"one":"almost 1 year","other":"almost %{count} years"},"half_a_minute":"half a minute","less_than_x_minutes":{"one":"less than a minute","other":"less than %{count} minutes"},"less_than_x_seconds":{"one":"less than 1 second","other":"less than %{count} seconds"},"over_x_years":{"one":"over 1 year","other":"over %{count} years"},"x_days":{"one":"1 day","other":"%{count} days"},"x_minutes":{"one":"1 minute","other":"%{count} minutes"},"x_months":{"one":"1 month","other":"%{count} months"},"x_seconds":{"one":"1 second","other":"%{count} seconds"},"x_years":{"one":"1 year","other":"%{count} years"}},"prompts":{"day":"Day","hour":"Hour","minute":"Minute","month":"Month","second":"Second","year":"Year"}},"errors":{"connection_refused":"Oops! Failed to connect to the Web Console middleware.\\nPlease make sure a rails development server is running.\\n","format":"%{attribute} %{message}","messages":{"accepted":"must be accepted","blank":"can\'t be blank","confirmation":"doesn\'t match %{attribute}","empty":"can\'t be empty","equal_to":"must be equal to %{count}","even":"must be even","exclusion":"is reserved","greater_than":"must be greater than %{count}","greater_than_or_equal_to":"must be greater than or equal to %{count}","in":"must be in %{count}","inclusion":"is not included in the list","invalid":"is invalid","less_than":"must be less than %{count}","less_than_or_equal_to":"must be less than or equal to %{count}","model_invalid":"Validation failed: %{errors}","not_a_number":"is not a number","not_an_integer":"must be an integer","odd":"must be odd","other_than":"must be other than %{count}","present":"must be blank","required":"must exist","taken":"has already been taken","too_long":{"one":"is too long (maximum is 1 character)","other":"is too long (maximum is %{count} characters)"},"too_short":{"one":"is too short (minimum is 1 character)","other":"is too short (minimum is %{count} characters)"},"wrong_length":{"one":"is the wrong length (should be 1 character)","other":"is the wrong length (should be %{count} characters)"}},"template":{"body":"There were problems with the following fields:","header":{"one":"1 error prohibited this %{model} from being saved","other":"%{count} errors prohibited this %{model} from being saved"}},"unacceptable_request":"A supported version is expected in the Accept header.\\n","unavailable_session":"Session %{id} is no longer available in memory.\\n\\nIf you happen to run on a multi-process server (like Unicorn or Puma) the process\\nthis request hit doesn\'t store %{id} in memory. Consider turning the number of\\nprocesses/workers to one (1) or using a different server in development.\\n"},"hello":"Hello world","helpers":{"select":{"prompt":"Please select"},"submit":{"create":"Create %{model}","submit":"Save %{model}","update":"Update %{model}"}},"i18n":{"plural":{"keys":["one","other"]}},"number":{"currency":{"format":{"delimiter":",","format":"%u%n","precision":2,"separator":".","significant":false,"strip_insignificant_zeros":false,"unit":"$"}},"format":{"delimiter":",","precision":3,"round_mode":"default","separator":".","significant":false,"strip_insignificant_zeros":false},"human":{"decimal_units":{"format":"%n %u","units":{"billion":"Billion","million":"Million","quadrillion":"Quadrillion","thousand":"Thousand","trillion":"Trillion","unit":""}},"format":{"delimiter":"","precision":3,"significant":true,"strip_insignificant_zeros":true},"storage_units":{"format":"%n %u","units":{"byte":{"one":"Byte","other":"Bytes"},"eb":"EB","gb":"GB","kb":"KB","mb":"MB","pb":"PB","tb":"TB"}}},"nth":{},"percentage":{"format":{"delimiter":"","format":"%n%"}},"precision":{"format":{"delimiter":""}}},"ransack":{"all":"all","and":"and","any":"any","asc":"ascending","attribute":"attribute","combinator":"combinator","condition":"condition","desc":"descending","or":"or","predicate":"predicate","predicates":{"blank":"is blank","cont":"contains","cont_all":"contains all","cont_any":"contains any","does_not_match":"doesn\'t match","does_not_match_all":"doesn\'t match all","does_not_match_any":"doesn\'t match any","end":"ends with","end_all":"ends with all","end_any":"ends with any","eq":"equals","eq_all":"equals all","eq_any":"equals any","false":"is false","gt":"greater than","gt_all":"greater than all","gt_any":"greater than any","gteq":"greater than or equal to","gteq_all":"greater than or equal to all","gteq_any":"greater than or equal to any","in":"in","in_all":"in all","in_any":"in any","lt":"less than","lt_all":"less than all","lt_any":"less than any","lteq":"less than or equal to","lteq_all":"less than or equal to all","lteq_any":"less than or equal to any","matches":"matches","matches_all":"matches all","matches_any":"matches any","not_cont":"doesn\'t contain","not_cont_all":"doesn\'t contain all","not_cont_any":"doesn\'t contain any","not_end":"doesn\'t end with","not_end_all":"doesn\'t end with all","not_end_any":"doesn\'t end with any","not_eq":"not equal to","not_eq_all":"not equal to all","not_eq_any":"not equal to any","not_in":"not in","not_in_all":"not in all","not_in_any":"not in any","not_null":"is not null","not_start":"doesn\'t start with","not_start_all":"doesn\'t start with all","not_start_any":"doesn\'t start with any","null":"is null","present":"is present","start":"starts with","start_all":"starts with all","start_any":"starts with any","true":"is true"},"search":"search","sort":"sort","value":"value"},"support":{"array":{"last_word_connector":", and ","two_words_connector":" and ","words_connector":", "}},"time":{"am":"am","formats":{"default":"%a, %d %b %Y %H:%M:%S %z","long":"%B %d, %Y %H:%M","short":"%d %b %H:%M"},"pm":"pm"},"views":{"common":{"reset_button":"Reset","search":"Search","search_button":"Search"},"user_songs":{"is_favorite_true":"Favorite Only","or_more":"or more","song_can_play_offline_true":"Offline Songs Only","song_diff_type_eq":"Diff Type","song_difficulty_gteq":"Difficulty","song_genre_eq":"Genre","song_title_cont":"Title","unselect":"Unselect","user_scores_achieve_eq":"Achieve"}}}'));
I18n.translations["ja"] = I18n.extend((I18n.translations["ja"] || {}), JSON.parse('{"activerecord":{"attributes":{"song":{"can_play_offline":"オフラインプレイ可","diff_type":"難易度","difficulty":"譜面定数","genre":"ジャンル","music_id":"楽曲ID","ruby":"ルビ","title":"タイトル","title_english":"英語版タイトル"},"song/diff_type":{"expert":"Expert","hard":"Hard","inferno":"Inferno","normal":"Normal"},"song/genre":{"2_5_dimension":"2.5次元","anime_pop":"アニメ/POP","original":"オリジナル","tanoc":"HARDCORE TANO*C","touhou":"東方アレンジ","variety":"バラエティ","vocaloid":"ボカロ"},"user":{"display_name":"表示名","name":"ID","password":"パスワード","password_confirmation":"パスワード(確認)"},"user_score":{"achieve":"FC状態","score":"スコア"},"user_score/achieve":{"all_marvelous":"All Marvelous","clear":"Clear","full_combo":"Full Combo","missless":"Missless"}},"errors":{"messages":{"record_invalid":"バリデーションに失敗しました: %{errors}","restrict_dependent_destroy":{"has_many":"%{record}が存在しているので削除できません","has_one":"%{record}が存在しているので削除できません"}}},"models":{"song":"楽曲","song_score":"楽曲スコア","user":"ユーザー"}},"date":{"abbr_day_names":["日","月","火","水","木","金","土"],"abbr_month_names":[null,"1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"],"day_names":["日曜日","月曜日","火曜日","水曜日","木曜日","金曜日","土曜日"],"formats":{"default":"%Y/%m/%d","long":"%Y年%m月%d日(%a)","short":"%m/%d"},"month_names":[null,"1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"],"order":["year","month","day"]},"datetime":{"distance_in_words":{"about_x_hours":{"one":"約1時間","other":"約%{count}時間"},"about_x_months":{"one":"約1ヶ月","other":"約%{count}ヶ月"},"about_x_years":{"one":"約1年","other":"約%{count}年"},"almost_x_years":{"one":"1年弱","other":"%{count}年弱"},"half_a_minute":"30秒前後","less_than_x_minutes":{"one":"1分以内","other":"%{count}分未満"},"less_than_x_seconds":{"one":"1秒以内","other":"%{count}秒未満"},"over_x_years":{"one":"1年以上","other":"%{count}年以上"},"x_days":{"one":"1日","other":"%{count}日"},"x_minutes":{"one":"1分","other":"%{count}分"},"x_months":{"one":"1ヶ月","other":"%{count}ヶ月"},"x_seconds":{"one":"1秒","other":"%{count}秒"},"x_years":{"one":"1年","other":"%{count}年"}},"prompts":{"day":"日","hour":"時","minute":"分","month":"月","second":"秒","year":"年"}},"errors":{"format":"%{attribute}%{message}","messages":{"accepted":"を受諾してください","blank":"を入力してください","confirmation":"と%{attribute}の入力が一致しません","empty":"を入力してください","equal_to":"は%{count}にしてください","even":"は偶数にしてください","exclusion":"は予約されています","greater_than":"は%{count}より大きい値にしてください","greater_than_or_equal_to":"は%{count}以上の値にしてください","inclusion":"は一覧にありません","invalid":"は不正な値です","less_than":"は%{count}より小さい値にしてください","less_than_or_equal_to":"は%{count}以下の値にしてください","model_invalid":"バリデーションに失敗しました: %{errors}","not_a_number":"は数値で入力してください","not_an_integer":"は整数で入力してください","odd":"は奇数にしてください","other_than":"は%{count}以外の値にしてください","present":"は入力しないでください","required":"を入力してください","taken":"はすでに存在します","too_long":"は%{count}文字以内で入力してください","too_short":"は%{count}文字以上で入力してください","wrong_length":"は%{count}文字で入力してください"},"template":{"body":"次の項目を確認してください","header":{"one":"%{model}にエラーが発生しました","other":"%{model}に%{count}個のエラーが発生しました"}}},"helpers":{"select":{"prompt":"選択してください"},"submit":{"create":"登録する","submit":"保存する","update":"更新する"}},"i18n":{"plural":{"keys":["other"]}},"number":{"currency":{"format":{"delimiter":",","format":"%n%u","precision":0,"separator":".","significant":false,"strip_insignificant_zeros":false,"unit":"円"}},"format":{"delimiter":",","precision":3,"separator":".","significant":false,"strip_insignificant_zeros":false},"human":{"decimal_units":{"format":"%n %u","units":{"billion":"十億","million":"百万","quadrillion":"千兆","thousand":"千","trillion":"兆","unit":""}},"format":{"delimiter":"","precision":3,"significant":true,"strip_insignificant_zeros":true},"storage_units":{"format":"%n%u","units":{"byte":"バイト","eb":"EB","gb":"GB","kb":"KB","mb":"MB","pb":"PB","tb":"TB"}}},"percentage":{"format":{"delimiter":"","format":"%n%"}},"precision":{"format":{"delimiter":""}}},"ransack":{"all":"全て","and":"と","any":"いずれか","asc":"昇順","attribute":"属性","combinator":"組み合わせ","condition":"状態","desc":"降順","or":"あるいは","predicate":"は以下である","predicates":{"blank":"は空である","cont":"は以下を含む","cont_all":"は以下の全てを含む","cont_any":"はいずれかを含む","does_not_match":"は以下と合致していない","does_not_match_all":"は以下の全てに合致していない","does_not_match_any":"は以下のいずれかに合致していない","end":"は以下で終わる","end_all":"は以下の全てで終わる","end_any":"は以下のいずれかで終わる","eq":"は以下と等しい","eq_all":"は以下の全てに等しい","eq_any":"は以下のいずれかに等しい","false":"偽","gt":"は以下より大きい","gt_all":"は以下の全てより大きい","gt_any":"は以下のいずれかより大きい","gteq":"は以下より大きいか等しい","gteq_all":"は以下の全てより大きいか等しい","gteq_any":"は以下のいずれかより大きいか等しい","in":"は以下の範囲内である","in_all":"は以下の全ての範囲内である","in_any":"は以下のいずれかの範囲内である","lt":"は以下よりも小さい","lt_all":"は以下の全てよりも小さい","lt_any":"は以下のいずれかより小さい","lteq":"は以下より小さいか等しい","lteq_all":"は以下の全てより小さいか等しい","lteq_any":"は以下のいずれかより小さいか等しい","matches":"は以下と合致している","matches_all":"は以下の全てと合致している","matches_any":"は以下のいずれかと合致している","not_cont":"は含まない","not_cont_all":"は以下の全てを含まない","not_cont_any":"は以下のいずれかを含まない","not_end":"は以下のどれでも終わらない","not_end_all":"は以下の全てで終わらない","not_end_any":"は以下のいずれかで終わらない","not_eq":"は以下と等しくない","not_eq_all":"は以下の全てと等しくない","not_eq_any":"は以下のいずれかに等しくない","not_in":"は以下の範囲内でない","not_in_all":"は以下の全ての範囲内","not_in_any":"は以下のいずれかの範囲内でない","not_null":"は無効ではない","not_start":"は以下で始まらない","not_start_all":"は以下の全てで始まらない","not_start_any":"は以下のいずれかで始まらない","null":"無効","present":"は存在する","start":"は以下で始まる","start_all":"は以下の全てで始まる","start_any":"は以下のどれかで始まる","true":"真"},"search":"検索","sort":"分類","value":"値"},"support":{"array":{"last_word_connector":"、","two_words_connector":"、","words_connector":"、"}},"time":{"am":"午前","formats":{"default":"%Y年%m月%d日(%a) %H時%M分%S秒 %z","long":"%Y/%m/%d %H:%M","short":"%m/%d %H:%M"},"pm":"午後"},"views":{"common":{"reset_button":"リセット","search":"検索","search_button":"検索"},"user_songs":{"is_favorite_true":"お気に入りのみ","or_more":"以上","song_can_play_offline_true":"オフライン曲のみ","song_diff_type_eq":"難易度","song_difficulty_gteq":"譜面定数","song_genre_eq":"ジャンル","song_title_cont":"タイトル","unselect":"未選択","user_scores_achieve_eq":"FC状況"}}}'));
export default I18n
