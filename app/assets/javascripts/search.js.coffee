# $('#select-search').change ->
# 	action = $(@).val()
# 	$('#search-form').attr('action', '/' + action)
$('#search-form').submit ->
	getSearch()

getSearch = ->
	$.ajax
		type: 'GET'
		url: "/#{$('#select-search').val()}"
		data: 
			query: $('#query-input').val()
		success: (data)->
			console.log(data)
	return false