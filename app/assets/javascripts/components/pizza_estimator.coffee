@PizzaEstimator = React.createClass
	
	getInitialState: ->
		nEaters: 0
		pizzas: {
			large: '0 large pizzas',
			medium: '0 medium pizzas',
			small: '0 small pizzas',
			remainder: '0 slices leftover'
		}
		complete: false

	handleChange: (e) ->
		nEaters = e.target.value
		@setState nEaters: nEaters

	calculatePizza: ->
		lgPizzaRem = @state.nEaters % 5
		if lgPizzaRem == 0
			@state.pizzas.large = (@state.nEaters / 5) + ' large pizza(s)'
			@forceUpdate()
			return
		else
			@state.pizzas.large = Math.floor(@state.nEaters / 5) + ' large pizza(s)'
			@forceUpdate()
		if lgPizzaRem < 4
			@state.pizzas.small = 1 + ' small pizza'
			@state.pizzas.remainder = 6 - (lgPizzaRem * 2) + ' slices'
			@forceUpdate()
			return
		else
			@state.pizzas.medium = 1 + ' medium pizza'
			@state.pizzas.remainder = 8 - (lgPizzaRem * 2) + ' slices'
			@forceUpdate()
			return

	handleSubmit: (e) ->
		e.preventDefault()
		@calculatePizza()
		@state.complete = true
		@forceUpdate()

	completeEstimate: ->
		return null unless @state.complete
		React.DOM.div
			className: 'text-center'
			React.DOM.h3 null,
				'You need ' + @state.pizzas.large + ', ' + @state.pizzas.medium + ', and ' + @state.pizzas.small
			React.DOM.a
				className: 'btn btn-success'
				href: 'https://www.seamless.com/menu/dominos-pizza-464-3rd-ave-new-york/293735'
				'Now go buy some pizza'
		

	render: -> 
		React.DOM.div
			className: 'text-center'
			React.DOM.form
				className: 'form-inline'
				onSubmit: @handleSubmit
				'How many pizza eaters?'
				React.DOM.input 
					className: 'form-control'
					type: 'number'
					name: 'nEaters'
					value: @state.nEaters
					onChange: @handleChange
				React.DOM.div null,
					React.DOM.button
						type: 'submit'
						className: 'btn btn-danger'
						'Munch the numbers'
			@completeEstimate()


